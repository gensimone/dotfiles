vim.g.mapleader = " "

local keymap = vim.keymap.set

-- Telescope / Find stuff.
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
keymap('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Ripgrep' })
keymap('n', '<leader>fb', builtin.buffers, { desc = 'Buffers' })
keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
keymap('n', '<leader>fp', ':NeovimProjectDiscover<CR>', { desc = 'Projects' })
keymap('n', '<leader>fm', function() builtin.man_pages({ sections = { 'ALL' } }) end, { desc = 'Man pages' })
keymap('n', '<leader>fc', function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end, { desc = 'Config files' })

-- Buffers
keymap("n", "<leader>bd", ":bd<CR>", { desc = 'Close current buffer' })
keymap('n', '<leader>n', ':bn<CR>', { desc = 'Next buffer' })
keymap('n', '<leader>p', ':bp<CR>', { desc = 'Previous buffer' })

-- Diagnostics
keymap('n', '<leader>ds', builtin.diagnostics, { desc = 'Diagnostics' })

-- Oil
keymap("n", "<leader>e", ":Oil --float<CR>", { desc = 'Oil' })

-- Git
keymap('n', '<leader>g', ':Neogit<CR>', { desc = 'Neogit' })
