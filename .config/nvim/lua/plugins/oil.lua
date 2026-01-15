return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
      -- Set to true to watch the filesystem for changes and reload oil
      watch_for_changes = false,
      default_file_explorer = true,
      -- Id is automatically added at the beginning, and name at the end
      -- See :help oil-columns
	  columns = {
		  "icon",
		  "permissions",
		  "size",
		  "mtime",
	  },
      view_options = {
          show_hidden = true
      },
	  keymaps = {
		  ["g?"] = { "actions.show_help", mode = "n" },
		  ["<CR>"] = "actions.select",
		  ["<C-s>"] = { "actions.select", opts = { vertical = true } },
		  ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
		  ["<C-t>"] = { "actions.select", opts = { tab = true } },
		  ["<C-p>"] = "actions.preview",
		  ["<C-c>"] = { "actions.close", mode = "n" },
		  ["<C-l>"] = "actions.refresh",
		  ["-"] = { "actions.parent", mode = "n" },
		  ["_"] = { "actions.open_cwd", mode = "n" },
		  ["`"] = { "actions.cd", mode = "n" },
		  ["g~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
		  ["gs"] = { "actions.change_sort", mode = "n" },
		  ["gx"] = "actions.open_external",
		  ["g."] = { "actions.toggle_hidden", mode = "n" },
		  ["g\\"] = { "actions.toggle_trash", mode = "n" },
	  },

  },
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
