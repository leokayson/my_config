-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- This file is automatically loaded by lazyvim.config.init
-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = LazyVim.safe_keymap_set

-- better up/down
map({"n", "x"}, "<Down>", "v:count == 0 ? 'gj' : 'j'", {desc = "Down", expr = true, silent = true})
map({"n", "x"}, "<Up>", "v:count == 0 ? 'gk' : 'k'", {desc = "Up", expr = true, silent = true})

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", {desc = "Go to Left Window", remap = true})
map("n", "<C-j>", "<C-w>j", {desc = "Go to Lower Window", remap = true})
map("n", "<C-k>", "<C-w>k", {desc = "Go to Upper Window", remap = true})
map("n", "<C-l>", "<C-w>l", {desc = "Go to Right Window", remap = true})

-- Resize window using <ctrl> arrow keys
map("n", "<C-S-Up>", "<cmd>resize +2<cr>", {desc = "Increase Window Height"})
map("n", "<C-S-Down>", "<cmd>resize -2<cr>", {desc = "Decrease Window Height"})
map("n", "<C-S-Left>", "<cmd>vertical resize -2<cr>", {desc = "Decrease Window Width"})
map("n", "<C-S-Right>", "<cmd>vertical resize +2<cr>", {desc = "Increase Window Width"})

-- Move Lines
map("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", {desc = "Move Down"})
map("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", {desc = "Move Up"})
map("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", {desc = "Move Down"})
map("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", {desc = "Move Up"})
map("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", {desc = "Move Down"})
map("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", {desc = "Move Up"})

-- Move words
map("n", "<C-Left>", "b", { noremap = true, desc = "Move to previous word" })
map("n", "<C-Right>", "w", { noremap = true, desc = "Move to next word" })
map("i", "<C-Left>", "<C-o>b", { noremap = true, desc = "Move to previous word" })
map("i", "<C-Right>", "<C-o>w", { noremap = true, desc = "Move to next word" })
map("v", "<C-Left>", "b", { noremap = true, desc = "Move to previous word" })
map("v", "<C-Right>", "w", { noremap = true, desc = "Move to next word" })

-- 选中单词（Normal 模式）
map("n", "<C-S-Left>", "vb", { noremap = true, desc = "Select word backward" })
map("n", "<C-S-Right>", "vw", { noremap = true, desc = "Select word forward" })
map("i", "<C-S-Left>", "<C-o>vb", { noremap = true, desc = "Select word backward" })
map("i", "<C-S-Right>", "<C-o>vw", { noremap = true, desc = "Select word forward" })
map("x", "<C-S-Left>", "b", { noremap = true, desc = "Extend selection backward" })
map("x", "<C-S-Right>", "w", { noremap = true, desc = "Extend selection forward" })

-- Insert 模式下使用 Ctrl+Backspace 删除前一个单词
map("i", "<C-Backspace>", "<C-o>vb<_d", { noremap = true, desc = "Delete previous word" })

-- Insert 模式下使用 Ctrl+Delete 删除后一个单词
map("i", "<C-Delete>", "<C-o>ve<_d", { noremap = true, desc = "Delete next word" })


-- use U for redo :))

-- scrolling
map('n', '<S-Up>', '<C-u>', defaults)
map('n', '<S-Down>', '<C-d>', defaults)

-- save file
map({"i", "x", "n", "s"}, "<C-s>", "<cmd>w<cr><esc>", {desc = "Save File"})

-- keywordprg
map("n", "<leader>K", "<cmd>norm! K<cr>", {desc = "Keywordprg"})

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")
