-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- 基础缩进设置（适用于所有文件类型）
vim.opt.expandtab = true -- 使用空格代替制表符
vim.opt.shiftwidth = 4 -- 自动缩进时的空格数
vim.opt.tabstop = 4 -- 一个制表符显示为多少个空格
vim.opt.softtabstop = 4 -- 按 Tab 键时插入的空格数

-- 对特定文件类型的额外设置（如果需要覆盖默认）
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*", -- 所有文件类型
	callback = function()
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})
