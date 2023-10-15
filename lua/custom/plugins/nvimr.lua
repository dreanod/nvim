-- [[ Configure Nvim-R ]]

if vim.fn.has('gui_running') or vim.o.termguicolors then
  vim.g.rout_color_input    = 'guifg=#98c379'
  vim.g.rout_color_normal   = 'guifg=#abb2bf'
  vim.g.rout_color_number   = 'guifg=#abb2bf'
  vim.g.rout_color_integer  = 'guifg=#abb2bf'
  vim.g.rout_color_float    = 'guifg=#abb2bf'
  vim.g.rout_color_complex  = 'guifg=#abb2bf'
  vim.g.rout_color_negnum   = 'guifg=#abb2bf'
  vim.g.rout_color_negfloat = 'guifg=#abb2bf'
  vim.g.rout_color_date     = 'guifg=#abb2bf'
  vim.g.rout_color_true     = 'guifg=#abb2bf'
  vim.g.rout_color_false    = 'guifg=#abb2bf'
  vim.g.rout_color_inf      = 'guifg=#56b6c2'
  vim.g.rout_color_constant = 'guifg=#abb2bf'
  vim.g.rout_color_string   = 'guifg=#abb2bf'
  vim.g.rout_color_error    = 'guifg=#abb2bf guibg=#be5046'
  vim.g.rout_color_warn     = 'guifg=#e06c75'
  vim.g.rout_color_index    = 'guifg=#d0d080'
end

-- key remaps
vim.cmd('let R_assign = 0')

-- custom key bindings
vim.keymap.set("n", "<leader>la", ":RSend load_all()<Enter>")
