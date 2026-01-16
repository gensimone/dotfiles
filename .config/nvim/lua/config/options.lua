local opt = vim.opt
local cmd = vim.cmd
local diagnostic = vim.diagnostic.config
opt.cursorline = false
opt.expandtab = true
opt.fillchars = { eob = ' ' }
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
cmd("set shm+=I")
cmd("set noshowmode")
cmd("set noshowcmd")
cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]
diagnostic({ underline = false })

-- Rounded corners
vim.o.winborder = "bold"

-- Automatically remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
