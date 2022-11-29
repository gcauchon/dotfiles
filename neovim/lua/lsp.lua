local function map(buffer, mode, lhs, rhs)
  local options = { noremap = true, silent = true }

  vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, options)
end

-- `on_attach` callback will be called after a language server
-- instance has been attached to an open buffer
local on_attach = function(client, buffer)
  map(buffer, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  map(buffer, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map(buffer, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  map(buffer, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map(buffer, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  map(buffer, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map(buffer, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>')
  map(buffer, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map(buffer, 'n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
  map(buffer, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>')
  map(buffer, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map(buffer, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')
end

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = "all",
  sync_install = false,
  ignore_install = {"phpdoc"},
  highlight = {
    enable = true,
    disable = {}
  }
}

-- Language server client
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig').elixirls.setup {
  cmd = { "/Users/gcauchon/Projects/opensource/elixir-ls/release/language_server.sh" },
  on_attach = on_attach,
  capabilities = capabilities
}

-- Auto-complete
local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      -- setting up snippet engine
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
	      feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
	      cmp.complete()
      else
	      fallback()
      end
    end, { "i", "s" }),
    ["<Down>"] = cmp.mapping(function(fallback)
       if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
	      feedkey("<Plug>(vsnip-expand-or-jump)", "")
      else
	      fallback()
      end
    end, {"i", "s"}),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
	      cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
	      feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
    ["<Up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	      cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
	      feedkey("<Plug>(vsnip-jump-prev)", "")
      else
	      fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' }
  })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))

