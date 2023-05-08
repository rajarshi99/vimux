vim.opt.relativenumber = true

-- Mappings
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
-- vim.keymap.set('n', '<Tab>', ':e<space>', { noremap = true })
vim.keymap.set('n', '<return>', 'o<ESC>', { noremap = true })
vim.keymap.set('n', '<S-l>', ':bnext<CR>', { noremap = true })
vim.keymap.set('n', '<S-h>', ':bprev<CR>', { noremap = true })

-- Sometimes not nice
-- vim.keymap.set('n', '<leader>=', 'gg<S-v>G=<C-o><C-o>zz', { noremap = true })
