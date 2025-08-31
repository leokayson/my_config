local path_sep = package.config:sub(1, 1)

local get_cwd = ya.sync(
                    function(state)
        return tostring(cx.active.current.cwd)
    end
)

local get_state_attr = ya.sync(
                           function(state, attr)
        return state[attr]
    end
                       )

local set_state_attr = ya.sync(
                           function(state, attr, value)
        state[attr] = value
    end
)

local ya_notify_info = function(msg)
    ya.notify {
        title = "cd_record",
        content = msg,
        timeout = 2,
        level = "info"
    }
end

local save_to_file = function(path, records)
    local file = io.open(path, "w")
    if file == nil then
        return
    end

    local key_array = {}
    for key, _ in pairs(records) do
        table.insert(key_array, key)
    end

    table.sort(key_array)

    for _, key in ipairs(key_array) do
        file:write(string.format("%s: %s\n", key, records[key]))
    end
    file:close()
end

local fzf_find = function(path, cli)
    local permit = ya.hide()
    local cmd = string.format("%s < \"%s\"", cli, path)
    local handle = io.popen(cmd, "r")
    local result = ""

    if handle then
        -- strip
        result = string.gsub(handle:read("*all") or "", "^%s*(.-)%s*$", "%1")
        handle:close()
    end
    permit:drop()

    local path, count = string.match(result or "", "(.-): (.*)")

    return path
end

local action_jump = function(path, cli)
    local path_2_jump = fzf_find(path, cli)
    local msg = ""

    if path_2_jump == nil then
        msg = "No path to jump"
    else
        ya.manager_emit("cd", {path_2_jump})
        msg = "Jump to [" .. path_2_jump .. "]"
    end
    
    ya_notify_info(msg)
end

local action_add = function(path)
    local msg = ""
    local path_2_record = get_cwd()
    local records = get_state_attr("records")
    
    if path_2_record == nil or #path_2_record == 0 then
        msg = "No path specified"
    else
        if records[path_2_record] == nil then
            msg = 'Add [' .. path_2_record .. ']'
            records[path_2_record] = 1
        else
            msg = 'Already exists [' .. path_2_record .. ']'
        end
    end
    
    ya_notify_info(msg)

    set_state_attr("records", records)
    save_to_file(path, records)
end

return {
    -- There're 4 params in state:
    --      path - the path of cd_record file,de default is ~/.config/cd_record.yaml
    --      records - the list of recorded paths, if nil is {home = 1}
    --      cli - the command line interface to use, default is fzf
    setup = function(state, options)
        local home_path = ""

        -- state.path
        if ya.target_family() == "windows" then
            home_path = os.getenv("USERPROFILE")
            state.path = options.path or (home_path .. "\\.config\\cd_record.yaml")
        else
            home_path = os.getenv("HOME")
            state.path = options.path or (home_path .. "/.config/cd_record.yaml")
        end
        
        -- state.cli
        state.cli = options.cli or "fzf"
        -- state.jump_notify
        state.jump_notify = options.jump_notify and true

        -- load the cd_record file
        local file, err = io.open(state.path, "r")
        local records = {}

        if file == nil then
            file:close()
            file = io.open(state.path, "w")
            records = {home_path = 1}
            save_to_file(state.path, records)
        else
            for line in file:lines() do
                local path, count = string.match(line, "(.-): (.*)")
                if path then
                    records[path] = tonumber(count)
                end
            end
        end
        file:close()

        state.records = records
    end,


    entry = function(self, jobs)
        local action = jobs.args[1]
        if not action then
            return
        end
        local path, cli = get_state_attr("path"), get_state_attr("cli")

        if action == "add" then
            action_add(path)
        elseif action == "jump" then
            action_jump(path, cli)
        end
    end
}
