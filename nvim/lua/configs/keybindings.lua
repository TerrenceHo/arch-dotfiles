-- split navigation shortcuts
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')

-- general keybindings
vim.keymap.set('n', '<leader>w', ':w<CR>')
-- vim.keymap.set('n', '<leader>d', ':bd')             -- delete the current buffer
vim.keymap.set('n', '<leader>l', ':nohlsearch<CR>') -- get rid of the highlights

-- system clipboard
vim.keymap.set({ 'n', "v" }, '<leader>y', '"+y') -- copy into system clipboard
vim.keymap.set('n', '<leader>Y', '"+y$')         -- copy rest of line into system clipboard
vim.keymap.set({ 'n', "v" }, '<leader>p', '"+p') -- paste from system clipboard
vim.keymap.set({ 'n', "v" }, '<leader>P', '"+P') -- paste from system clipboard

-- fzf search utilities
vim.keymap.set('n', '<leader>f', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })
