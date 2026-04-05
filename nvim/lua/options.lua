vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use UTF-8 encoding
vim.opt.encoding = "utf-8"

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse support
vim.opt.mouse = "a"

-- True color support
vim.opt.termguicolors = true

-- Command line completion
vim.opt.wildmode = "longest,list"

-- Case insensitive search unless uppercase letters are used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Split behavior
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Disable swapfiles but keep persistent undo
vim.opt.swapfile = false
vim.opt.undofile = true

-- Scroll context
vim.opt.scrolloff = 8

-- Auto read file changes
vim.opt.autoread = true

-- Restore cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.cmd("normal! g'\"")
    end
  end,
})
