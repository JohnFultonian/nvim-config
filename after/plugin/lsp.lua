local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })

	local opts = { buffer = bufnr, remap = false }


	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

-- here you can setup the language servers
require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { 'tsserver', 'tsserver', 'terraformls', 'lua_ls', 'yamlls', 'html', 'jsonls', 'jedi_language_server' },
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,

		lua_ls = function()
			require('lspconfig').lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "color" }
						},
					}
				}
			})
		end,
	},
})


local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({select = true}),
		['<Tab>'] = cmp_action.luasnip_supertab(),
		['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
	}),
})
