local wezterm = require("wezterm")
local platform = require("utils.platform")()
local act = wezterm.action

local mod = {}

if platform.is_mac then
    mod.SUPER = "SUPER"
    mod.SUPER_REV = "CTRL|SUPER"
elseif platform.is_win or platform.is_linux then
    mod.SUPER = "CTRL" -- to not conflict with Windows key shortcuts
    mod.SUPER_REV = "CTRL|ALT"
end

local keys = { -- misc/useful --
{key = "F1", mods = "NONE", action = act.ActivateCommandPalette},
{key = "F3", mods = "NONE", action = act.ShowLauncher}, 
{key = "F4", mods = "NONE", action = act.ShowTabNavigator},
{key = "F11", mods = "NONE", action = act.ToggleFullScreen},
{key = "F12", mods = "NONE", action = act.ShowDebugOverlay},
{key = "f", mods = mod.SUPER, action = act.Search({CaseInSensitiveString = ""})}, -- copy/paste --
{key = "Insert", mods = "CTRL", action = act.CopyTo("Clipboard")},
{key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard")}, -- tabs --
-- tabs: spawn+close
{key = "t", mods = "CTRL", action = act.SpawnTab("DefaultDomain")},
{key = "w", mods = "CTRL", action = act.CloseCurrentTab({confirm = false})}, -- tabs: navigation
{key = "[", mods = "CTRL", action = act.ActivateTabRelative(-1)},
{key = "]", mods = "CTRL", action = act.ActivateTabRelative(1)},

-- Clears the scrollback and viewport leaving the prompt line the new first line.
{key = 'C', mods = 'CTRL|SHIFT', action = act.ClearScrollback 'ScrollbackAndViewport'}, -- window --
-- spawn windows
{key = "n", mods = "CTRL|SHIFT", action = act.SpawnWindow},

{key = "\\", mods = mod.SUPER_REV, action = act.SplitVertical({domain = "CurrentPaneDomain"})},
{key = "-", mods = mod.SUPER_REV, action = act.SplitHorizontal({domain = "CurrentPaneDomain"})},
{key = "0", mods = mod.SUPER_REV, action = act.SplitPane({ direction = 'Right', command = { domain = 'CurrentPaneDomain' }})},
{key = "z", mods = mod.SUPER_REV, action = act.TogglePaneZoomState},
{key = "w", mods = mod.SUPER, action = act.CloseCurrentPane({confirm = true})}, -- panes: navigation
{key = "i", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Up")},
{key = "k", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Down")},
{key = "j", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Left")},
{key = "l", mods = mod.SUPER_REV, action = act.ActivatePaneDirection("Right")}, -- panes: resize
{key = "UpArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({"Up", 1})},
{key = "DownArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({"Down", 1})},
{key = "LeftArrow", mods = mod.SUPER_REV, action = act.AdjustPaneSize({"Left", 1})},

{key = "LeftArrow",  mods = "CTRL", action = act.CopyMode 'MoveForwardWordEnv'},
{key = "RightArrow", mods = "CTRL", action = act.CopyMode 'MoveBackwardWord'}, 
-- fonts: resize
{key = "=", mods = mod.SUPER, action = act.IncreaseFontSize},
{key = "-", mods = mod.SUPER, action = act.DecreaseFontSize} -- key-tables --
}

local mouse_bindings = { -- Ctrl-click will open the link under the mouse cursor
{event = {Up = {streak = 1, button = "Left"}}, mods = "CTRL", action = act.OpenLinkAtMouseCursor},
-- Move mouse will only select text and not copy text to clipboard
{event = {Down = {streak = 1, button = "Left"}}, mods = "NONE", action = act.SelectTextAtMouseCursor("Cell")},
{event = {Up = {streak = 1, button = "Left"}}, mods = "NONE", action = act.ExtendSelectionToMouseCursor("Cell")},
{event = {Drag = {streak = 1, button = "Left"}}, mods = "NONE", action = act.ExtendSelectionToMouseCursor("Cell")},
-- Triple Left click will select a line
{event = {Down = {streak = 3, button = "Left"}}, mods = "NONE", action = act.SelectTextAtMouseCursor("Line")},
{event = {Up = {streak = 3, button = "Left"}}, mods = "NONE", action = act.SelectTextAtMouseCursor("Line")},
-- Double Left click will select a word
{event = {Down = {streak = 2, button = "Left"}}, mods = "NONE", action = act.SelectTextAtMouseCursor("Word")},
{event = {Up = {streak = 2, button = "Left"}}, mods = "NONE", action = act.SelectTextAtMouseCursor("Word")},
-- Turn on the mouse wheel to scroll the screen
{event = {Down = {streak = 1, button = {WheelUp = 1}}}, mods = "NONE", action = act.ScrollByCurrentEventWheelDelta},
{event = {Down = {streak = 1, button = {WheelDown = 1}}}, mods = "NONE", action = act.ScrollByCurrentEventWheelDelta},
-- click Right to paste{key = "Insert", mods = "SHIFT", action = act.PasteFrom("Clipboard")}
{event = {Up = {streak = 1, button = "Right"}}, mods = "NONE", action = act.PasteFrom("Clipboard")},
}

return {disable_default_key_bindings = true, disable_default_mouse_bindings = true,
        leader = {key = "Space", mods = "CTRL|SHIFT"}, keys = keys, key_tables = key_tables,
        mouse_bindings = mouse_bindings}
