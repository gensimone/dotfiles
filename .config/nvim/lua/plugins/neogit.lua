return {
  'NeogitOrg/neogit',
  lazy = true,
  dependencies = {
    'nvim-lua/plenary.nvim',         -- required
    'sindrets/diffview.nvim',        -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },
  cmd = 'Neogit'
}
