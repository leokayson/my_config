-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.expandtab = true -- Use space to indent
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4      --
vim.opt.softtabstop = 4

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*", -- 所有文件类型
    callback = function()
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
    end,
})

vim.opt.guicursor = "n-v-c-sm:ver100,i-ci-ve:ver25,r-cr-o:hor20"
