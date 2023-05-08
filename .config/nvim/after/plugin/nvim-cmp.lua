local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup({
  mapping = cmp.mapping.preset.insert {
    ['  '] = cmp.mapping(function(fallback)
      if luasnip.jumpable() then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
})
