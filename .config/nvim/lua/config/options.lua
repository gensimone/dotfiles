local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true
opt.undofile = true

-- UI
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "no"
opt.fillchars = { eob = ' ' }

-- Behavior
opt.wrap = false
opt.scrolloff = 8
opt.updatetime = 300

-- statusline
-- vim.o.statusline = "%m %f"

local cmd = vim.cmd
cmd("set shm+=I")
cmd("set noshowmode")
cmd("set noshowcmd")

-- make transparent window transparent
cmd("highlight Pmenu guibg=NONE")
cmd("highlight Float guibg=NONE")
cmd("highlight NormalFloat guibg=NONE")

-- Auto formatting.
cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

-- Diagnostic
vim.diagnostic.config({
    underline = false,
})

-- Rounded corners
vim.o.winborder = "rounded"
