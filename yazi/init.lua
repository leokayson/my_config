-- You can configure your bookmarks by lua language
local bookmarks = {}

local path_sep = package.config:sub(1, 1)
local home_path = ya.target_family() == "windows" and os.getenv("USERPROFILE") or os.getenv("HOME")
if ya.target_family() == "windows" then
	table.insert(bookmarks, {
		tag = "user",
		path = home_path,
		key = "u",
	})
	table.insert(bookmarks, {
		tag = "downloads",
		path = home_path .. path_sep .. "Downloads",
		key = "d",
	})
end
	table.insert(bookmarks, {
		tag = "home",
		path = home_path,
		key = "h",
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
	path = home_path .. path_sep .. '.config' .. path_sep .. 'yazi_bookmarks',
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

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
})

require("custom-shell"):setup({
    history_path = "default",
    save_history = false,
})

require("keyjump"):setup({
	icon_fg = "#778899",
	first_key_fg = "#df6249",
})