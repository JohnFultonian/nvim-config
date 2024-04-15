vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true


vim.opt.scrolloff = 8

vim.g.mapleader = " "

local function autosave()
    if vim.bo.buftype == 'normal' and not vim.bo.readonly and vim.bo.modifiable then
        local success, err = pcall(vim.cmd, 'write')
        if not success then
            vim.notify("Autosave failed: " .. err, vim.log.levels.ERROR)
        end
    end
end


vim.api.nvim_create_autocmd({"TextChanged", "TextChangedI"}, {
    pattern = "*",
    callback = autosave,
})
