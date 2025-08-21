-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

-- better up/down
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-S-i>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-S-j>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-S-j>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-S-l>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Move words
map("n", "<C-Left>", "<S-Left>", { noremap = true, desc = "Move to previous word" })
map("n", "<C-Right>", "<S-Right>", { noremap = true, desc = "Move to next word" })
map("i", "<C-Left>", "<S-Left>", { noremap = true, desc = "Move to previous word" })
map("i", "<C-Right>", "<S-Right>", { noremap = true, desc = "Move to next word" })
map("v", "<C-Left>", "<S-Left>", { noremap = true, desc = "Move to previous word" })
map("v", "<C-Right>", "<S-Right>", { noremap = true, desc = "Move to next word" })

-- Delete words
map("n", "d<Delete>", "dw", { noremap = true, desc = "Delete to later word" })
map("n", "d<Backspace>", "db", { noremap = true, desc = "Delete to previous word" })
map("n", "d<Right>", "dw", { noremap = true, desc = "Delete to later word" })
map("n", "d<Left>", "db", { noremap = true, desc = "Delete to previous word" })
map("i", "<C-Delete>", "<C-o>dw", { noremap = true, desc = "Delete to previous word" })
map("i", "<C-Backspace>", "<C-w>", { noremap = true, desc = "Delete to previous word" })

-- Select words
map("n", "<C-S-Left>", "vb", { noremap = true, desc = "Select word backward" })
map("n", "<C-S-Right>", "vw", { noremap = true, desc = "Select word forward" })
map("i", "<C-S-Left>", "<C-o>vb", { noremap = true, desc = "Select word backward" })
map("i", "<C-S-Right>", "<C-o>vw", { noremap = true, desc = "Select word forward" })
map("x", "<C-S-Left>", "b", { noremap = true, desc = "Extend selection backward" })
map("x", "<C-S-Right>", "w", { noremap = true, desc = "Extend selection forward" })

-- better indenting
map("n", "<A-Left>", "<gv", { noremap = true })
map("n", "<A-Right>", ">gv", { noremap = true })
map("i", "<A-Left>", "<Esc><<i", { noremap = true })
map("i", "<A-Right>", "<Esc>>>i", { noremap = true })

-- use U for redo :))
map("n", "U", "<C-r>", { noremap = true, desc = "Redo" })

-- Ctrl+c to copt into system clipboard
map("v", "<C-c>", '"+y', { noremap = true, desc = "Yank into system clipboard" })

-- scrolling
map("n", "<Pageup>", "<C-u>", { noremap = true })
map("n", "<Pagedown>", "<C-d>", { noremap = true })

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
