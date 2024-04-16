vim.cmd([[
  augroup MyColorScheme
    autocmd!
    autocmd VimEnter * ++once colorscheme carbonfox
    autocmd VimEnter * ++once lua vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
    autocmd VimEnter * ++once lua vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
  augroup END
]])
