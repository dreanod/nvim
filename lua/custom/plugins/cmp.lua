-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local lspkind = require 'lspkind'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
    { name = 'luasnip' },
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    -- ['<C-Space>'] = cmp.mapping.complete {},
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item(cmp_select_opts)
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item(cmp_select_opts)
      else
        cmp.complete()
      end
    end),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    documentation = {
      max_height = 15,
      max_width = 60,
    }
  },
  formatting = {
    fields = {'abbr', 'kind', 'menu'},
    format = lspkind.cmp_format({
              mode = 'symbol', -- show only symbol annotations
              maxwidth = 100, -- prevent the popup from showing more than provided characters
              ellipsis_char = '...', -- the truncated part when popup menu exceed maxwidth
              before = function(entry, item)
                  local menu_icon = {
                      nvim_lsp = '',
                      nvim_lua = '',
                      vsnip = '',
                      path = '',
                      cmp_zotcite = 'z',
                      cmp_nvim_r = ''
                  }
                  item.menu = menu_icon[entry.source.name]
                  return item
              end
    })
  }
})

require "lsp_signature".setup({
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = "rounded"
  }
})

