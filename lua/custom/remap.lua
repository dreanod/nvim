-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keymaps for terminal mode
vim.keymap.set('t', '<Esc>', '<c-\\><c-n>', { silent = true })

-- Remap for file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open File Explorer (Ex)" })
