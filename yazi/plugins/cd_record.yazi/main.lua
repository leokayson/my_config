local path_sep = package.config:sub(1, 1)

local get_cwd = ya.sync(function(state)
    return to_string(cx.active.current.cwd)
end
                         )

local get_state_attr = ya.sync(
                           function(state, attr)
        return state[attr]
    end
                       )

-- local set_state_attr = ya.sync(
--                            function(state, attr, value)
--         state[attr] = value
--     end
--                        )

-- local set_bookmarks = ya.sync(
--                           function(state, path, value)
--         state.bookmarks[path] = value
--     end
--                       )

local sort_cdrs = function(cdrs, key1, key2, reverse)
    reverse = reverse or false
    table.sort(
        cdrs, function(x, y)
            if x[key1] == nil and y[key1] == nil then
                return x[key2] < y[key2]
            elseif x[key1] == nil then
                return false
            elseif y[key1] == nil then
                return true
            else
                return x[key1] < y[key1]
            end
        end
    )
    if reverse then
        local n = #cdrs
        for i = 1, math.floor(n / 2) do
            cdrs[i], cdrs[n - i + 1] = cdrs[n - i + 1], cdrs[i]
        end
    end
    return cdrs
end

local save_to_file = function(cdr_path, cdr)
    local file = io.open(cdr_path, "w")
    if file == nil then
        return
    end
    local array = {}
    for _, item in pairs(cdr) do
        table.insert(array, item)
    end
    sort_cdrs(array, "path", "count", true)
    for _, item in ipairs(array) do
        file:write(string.format("%s: %s\n", item.path, item.count))
    end
    file:close()
end

-- local fzf_find = function(cli, mb_path)
--     local permit = ya.hide()
--     local cmd = string.format("%s < \"%s\"", cli, mb_path)
--     local handle = io.popen(cmd, "r")
--     local result = ""
--     if handle then
--         -- strip
--         result = string.gsub(handle:read("*all") or "", "^%s*(.-)%s*$", "%1")
--         handle:close()
--     end
--     permit:drop()
--     local tag, path, key = string.match(result or "", "(.-)\t(.-)\t(.*)")
--     return path
-- end

-- local which_find = function(bookmarks)
--     local cands = {}
--     for path, item in pairs(bookmarks) do
--         if #item.tag ~= 0 then
--             table.insert(
--                 cands, {
--                     desc = item.tag,
--                     on = item.key,
--                     path = item.path
--                 }
--             )
--         end
--     end
--     sort_bookmarks(cands, "on", "desc", false)
--     if #cands == 0 then
--         ya.notify {
--             title = "Bookmarks",
--             content = "Empty bookmarks",
--             timeout = 2,
--             level = "info"
--         }
--         return nil
--     end
--     local idx = ya.which {
--         cands = cands
--     }
--     if idx == nil then
--         return nil
--     end
--     return cands[idx].path
-- end

-- local action_jump = function(bookmarks, path, jump_notify)
--     if path == nil then
--         return
--     end
--     local tag = bookmarks[path].tag
--     if string.sub(path, -1) == path_sep then
--         ya.manager_emit("cd", {path})
--     else
--         ya.manager_emit("reveal", {path})
--     end
--     if jump_notify then
--         ya.notify {
--             title = "Bookmarks",
--             content = 'Jump to "' .. tag .. '"',
--             timeout = 2,
--             level = "info"
--         }
--     end
-- end

-- local generate_key = function(bookmarks)
--     local keys = get_state_attr("keys")
--     local key2rank = get_state_attr("key2rank")
--     local mb = {}
--     for _, item in pairs(bookmarks) do
--         if #item.key == 1 then
--             table.insert(mb, item.key)
--         end
--     end
--     if #mb == 0 then
--         return keys[1]
--     end
--     table.sort(
--         mb, function(a, b)
--             return key2rank[a] < key2rank[b]
--         end
--     )
--     local idx = 1
--     for _, key in ipairs(keys) do
--         if idx > #mb or key2rank[key] < key2rank[mb[idx]] then
--             return key
--         end
--         idx = idx + 1
--     end
--     return nil
-- end

-- local action_save = function(mb_path, bookmarks, path)
--     if path == nil or #path == 0 then
--         return
--     end

--     local path_obj = bookmarks[path]
--     -- check tag
--     set_bookmarks(
--         path, {
--             path = path,
--             count = 1
--         }
--     )
--     bookmarks = get_state_attr("bookmarks")
--     save_to_file(mb_path, bookmarks)
--     ya.notify {
--         title = "Bookmarks",
--         content = '"' .. path .. '" saved"',
--         timeout = 2,
--         level = "info"
--     }
-- end

-- local action_delete = function(mb_path, bookmarks, path)
--     if path == nil then
--         return
--     end
--     local tag = bookmarks[path].tag
--     set_bookmarks(path, nil)
--     bookmarks = get_state_attr("bookmarks")
--     save_to_file(mb_path, bookmarks)
--     ya.notify {
--         title = "Bookmarks",
--         content = '"' .. tag .. '" deleted',
--         timeout = 2,
--         level = "info"
--     }
-- end

-- local action_delete_all = function(mb_path)
--     local value, event = ya.input(
--                              {
--             title = "Delete all bookmarks? (y/n)",
--             position = {
--                 "top-center",
--                 y = 3,
--                 w = 40
--             }
--         }
--                          )
--     if event ~= 1 then
--         return
--     end
--     if string.lower(value) == "y" then
--         set_state_attr("bookmarks", {})
--         save_to_file(mb_path, {})
--         ya.notify {
--             title = "Bookmarks",
--             content = "All bookmarks deleted",
--             timeout = 2,
--             level = "info"
--         }
--     else
--         ya.notify {
--             title = "Bookmarks",
--             content = "Cancel delete",
--             timeout = 2,
--             level = "info"
--         }
--     end
-- end

return {
    setup = function(state, options)
        state.path = options.path or
                         (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\cd_record.yaml") or
                         (os.getenv("HOME") .. "/.config/yazi/cd_record.yaml")
        state.cli = options.cli or "fzf"
        state.jump_notify = options.jump_notify and true
        -- init the keys
        local keys = options.keys or "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        state.keys = {}
        state.key2rank = {}
        for i = 1, #keys do
            local char = keys:sub(i, i)
            table.insert(state.keys, char)
            state.key2rank[char] = i
        end

        -- init the bookmarks
        local bookmarks = {}
        for _, item in pairs(options.bookmarks or {}) do
            bookmarks[item.path] = {
                path = item.path,
                count = item.count
            }
        end
        -- load the config
        local file, err = io.open(state.path, "r")
        if file == nil then
            file = io.open(state.path, "w")
            file:close()
            file = io.open(state.path, "r")
        end

        for line in file:lines() do
            local path, count = string.match(line, "(.-): (.*)")
            if path then
                bookmarks[path] = {
                    path = path,
                    count = tonumber(count)
                }
            end
        end
        file:close()
        -- create bookmarks file to enable fzf
        save_to_file(state.path, bookmarks)
        state.bookmarks = bookmarks
    end,
    entry = function(self, jobs)
        local action = jobs.args[1]
        if not action then
            return
        end
        local mb_path, cli, bookmarks, jump_notify = get_state_attr("path"), get_state_attr("cli"),
                                                     get_state_attr("bookmarks"), get_state_attr("jump_notify")
        if action == "save" then
            action_save(mb_path, bookmarks, get_cwd())
        end
    end
}
