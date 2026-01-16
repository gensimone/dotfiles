return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      require'nvim-treesitter.config'.setup {
          ensure_install = { 'c', 'python', 'lua', 'bash' },
          auto_install = True,
          highlight = { enable = true },
          indent = { enable = true }
      }
  end
}
