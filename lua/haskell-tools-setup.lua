local ht = require('haskell-tools')

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  float = {
	border = "single",
	format = function(diagnostic)
		return string.format(
			"%s (%s) [%s]",
			diagnostic.message,
			diagnostic.source,
			diagnostic.code or diagnostic.user_data.lsp.code
		)
	end,
}})

vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>oe', '<cmd>Telescope diagnostics<CR>', { noremap = true, silent = true })

local opts = { noremap = true, silent = true, buffer = bufnr }
ht.setup {
  hls = {
    -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
    on_attach = function(client, bufnr)
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<Leader>ca', vim.lsp.codelens.run, opts)
      vim.keymap.set('n', '<Leader>hs', ht.hoogle.hoogle_signature, opts)
      -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
    end,
  },
}
