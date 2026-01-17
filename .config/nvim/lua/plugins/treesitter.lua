return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
      require("nvim-treesitter").setup({
          install = { 'lua', 'c', 'python', 'bash' },
          config = {
              highlight = {
                  enable = true,
              }
          }
      })
  end
}
