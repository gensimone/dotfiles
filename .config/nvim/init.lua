-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt= vim.opt
local cmd = vim.cmd
local diagnostic = vim.diagnostic.config
opt.clipboard = "unnamedplus"
opt.cursorline = false
opt.expandtab = true
opt.hlsearch = false
opt.ignorecase = true
opt.incsearch = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftwidth = 4
opt.signcolumn = "no"
opt.smartcase = true
opt.smartindent = true
opt.tabstop = 4
opt.termguicolors = true
opt.undofile = true
opt.updatetime = 300
opt.wrap = false
cmd("set noshowmode")
cmd("set noshowcmd")
cmd("colorscheme default")
cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
diagnostic({ underline = false })

-- Rounded corners
vim.o.winborder = "bold"

-- Automatically remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = { enabled = false },
  change_detection = { enabled = false }
})

-- Keymaps
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Telescope
local telescope_builtin = require('telescope.builtin')
keymap('n', '<leader>ff', telescope_builtin.find_files)
keymap('n', '<leader>fr', telescope_builtin.oldfiles)
keymap('n', '<leader>fg', telescope_builtin.live_grep)
keymap('n', '<leader>fb', telescope_builtin.buffers)
keymap('n', '<leader>fh', telescope_builtin.help_tags)
keymap('n', '<leader>fm', function() telescope_builtin.man_pages({ sections = { 'ALL' } }) end)
keymap('n', '<leader>fc', function() telescope_builtin.find_files({ cwd = vim.fn.stdpath('config') }) end)
keymap('n', '<leader>ds', telescope_builtin.diagnostics)

-- Various stuff
keymap('n', '<leader>bd', ':bd<CR>')
keymap('n', '<leader>n', ':bn<CR>')
keymap('n', '<leader>p', ':bp<CR>')
keymap('n', '<leader>e', ':Oil<CR>')
keymap('n', '<leader>g', ':Neogit<CR>')
keymap('n', '<leader>r', ':lua vim.lsp.buf.rename()<CR>')
keymap('n', '<leader>y', '"+y')
keymap('n', '<leader>t', ':term<CR>')
keymap({'n', 'x'}, "gz", "<Cmd>MultipleCursorsAddMatches<CR>")
keymap({'n', 'x'}, "<C-n>", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>")
keymap('', 'f', function() require('hop').hint_char1({ current_line_only = false}) end, opts)

-- Terminal
keymap("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)
keymap('t', '<C-h>', [[<C-\><C-n><C-w>h]], opts)
keymap('t', '<C-j>', [[<C-\><C-n><C-w>j]], opts)
keymap('t', '<C-k>', [[<C-\><C-n><C-w>k]], opts)
keymap('t', '<C-l>', [[<C-\><C-n><C-w>l]], opts)
keymap("t", "<A-h>", [[<C-\><C-n><C-w><]], opts)
keymap("t", "<A-l>", [[<C-\><C-n><C-w>>]], opts)
keymap("t", "<A-j>", [[<C-\><C-n><C-w>-]], opts)
keymap("t", "<A-k>", [[<C-\><C-n><C-w>+]], opts)
-- vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
--     pattern = { "*" },
--     callback = function()
--         if vim.opt.buftype:get() == "terminal" then
--             vim.cmd(":startinsert")
--         end
--     end
-- })
