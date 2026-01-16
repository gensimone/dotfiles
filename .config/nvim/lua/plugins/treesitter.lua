return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require'nvim-treesitter.config'.setup {
        ensure_install = {'c', 'python', 'lua', 'bash'},
        auto_install = True,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    }
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { '<filetype>' },
        callback = function() vim.treesitter.start() end,
    })
end
}
