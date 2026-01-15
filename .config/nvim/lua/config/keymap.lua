vim.g.mapleader = " "

local keymap = vim.keymap.set

-- Oil
keymap("n", "<leader>e", ":Oil<CR>", { desc = 'Oil' })

-- Buffers
keymap("n", "<leader>bd", ":bd<CR>", { desc = 'Close current buffer' })

-- Telescope
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, { desc = 'Find files' })
keymap('n', '<leader>fr', builtin.oldfiles, { desc = 'Recent files' })
keymap('n', '<leader>fg', builtin.live_grep, { desc = 'Ripgrep' })
keymap('n', '<leader>bb', builtin.buffers, { desc = 'Buffers' })
keymap('n', '<leader>fh', builtin.help_tags, { desc = 'Help' })
keymap('n', '<leader>fc', function() builtin.find_files({ cwd = vim.fn.stdpath("config") }) end,
    { desc = 'Config files' })
keymap('n', '<leader>ds', builtin.diagnostics, { desc = 'Diagnostics' })
keymap('n', '<leader>m', function() builtin.man_pages({ sections = { 'ALL' } }) end, { desc = 'Man pages' })
keymap('n', '<leader>a', ':cd %:p:h<CR>', { desc = 'Chdir current buffer' })

-- Git
keymap('n', '<leader>g', ':Neogit<CR>', { desc = 'Neogit' })
