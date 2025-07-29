require("starship"):setup()

-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
	table.insert(bookmarks, {
		tag = "Scoop Local",

		path = (os.getenv("SCOOP") or home_path .. "\\scoop") .. "\\",
		key = "p",
	})
	table.insert(bookmarks, {
		tag = "Scoop Global",
		path = (os.getenv("SCOOP_GLOBAL") or "C:\\ProgramData\\scoop") .. "\\",
		key = "P",
	})
end
table.insert(bookmarks, {
	tag = "Desktop",
	path = home_path .. path_sep .. "Desktop" .. path_sep,
	key = "d",
})

require("yamb"):setup({
	-- Optional, the path ending with path seperator represents folder.
	bookmarks = bookmarks,
	-- Optional, recieve notification everytime you jump.
	jump_notify = true,
	-- Optional, the cli of fzf.
	cli = "fzf",
	-- Optional, a string used for randomly generating keys, where the preceding characters have higher priority.
	keys = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
	-- Optional, the path of bookmarks
	path = (ya.target_family() == "windows" and os.getenv("APPDATA") .. "\\yazi\\config\\bookmark")
		or (os.getenv("HOME") .. "/.config/yazi/bookmark"),
})

require("projects"):setup({
	save = {
		method = "yazi", -- yazi | lua
		yazi_load_event = "@projects-load", -- event name when loading projects in `yazi` method
		lua_save_path = "", -- path of saved file in `lua` method, comment out or assign explicitly
		-- default value:
		-- windows: "%APPDATA%/yazi/state/projects.json"
		-- unix: "~/.local/state/yazi/projects.json"
	},
	last = {
		update_after_save = true,
		update_after_load = true,
		load_after_start = false,
	},
	merge = {
		event = "projects-merge",
		quit_after_merge = false,
	},
	event = {
		save = {
			enable = true,
			name = "project-saved",
		},
		load = {
			enable = true,
			name = "project-loaded",
		},
		delete = {
			enable = true,
			name = "project-deleted",
		},
		delete_all = {
			enable = true,
			name = "project-deleted-all",
		},
		merge = {
			enable = true,
			name = "project-merged",
		},
	},
	notify = {
		enable = true,
		title = "Projects",
		timeout = 3,
		level = "info",
	},
})

require("relative-motions"):setup({ show_numbers = "relative", show_motion = true, enter_mode = "first" })

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

require("searchjump"):setup({
	unmatch_fg = "#b2a496",
    match_str_fg = "#000000",
    match_str_bg = "#73AC3A",
    first_match_str_fg = "#000000",
    first_match_str_bg = "#73AC3A",
    label_fg = "#EADFC8",
    label_bg = "#BA603D",
    only_current = false,
    show_search_in_statusbar = false,
    auto_exit_when_unmatch = false,
    enable_capital_label = true,
	-- mapdata = require("sjch").data,
	search_patterns = ({"hell[dk]d","%d+.1080p","第%d+集","第%d+话","%.E%d+","S%d+E%d+",})
})

require("custom-shell"):setup({
    history_path = "default",
    save_history = false,
})