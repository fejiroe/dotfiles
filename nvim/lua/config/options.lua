vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.incsearch = true      
vim.o.inccommand = 'split'

vim.cmd('filetype plugin on')
vim.o["termguicolors"] = true

vim.o.expandtab = true 
vim.o.softtabstop = 4 
vim.o.shiftwidth = 4 

vim.o.undofile = true

vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)

vim.g.have_nerd_font = true
vim.o.cursorline = true

vim.o.showmode = false
vim.o.cmdheight=0
vim.opt.laststatus = 0

vim.o.splitright = true
vim.o.splitbelow = true

vim.cmd('let g:netrw_winsize = 21')
vim.cmd('let g:netrw_keepdir = 0')

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})
