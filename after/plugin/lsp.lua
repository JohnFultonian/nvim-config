local lsp_zero = require('lsp-zero')

-- Function to create and display a floating window for diagnostics
local function show_diagnostics()
    local opts = {
        focusable = false,
        close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
        border = 'rounded',
        source = 'always',  -- Displays where the diagnostic is coming from
        prefix = ' ',
        scope = 'cursor',  -- Limits the diagnostics to the current cursor position
    }
    vim.diagnostic.open_float(nil, opts)
end

-- Function to automatically show diagnostics in a floating window on cursor hover
local function cursor_hover()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line_diagnostics = vim.diagnostic.get(0, {lnum = cursor_pos[1] - 1})
    if #line_diagnostics > 0 then
        show_diagnostics()
    end
end

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })

	local opts = { buffer = bufnr, remap = false }


	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
        buffer = bufnr,
        callback = cursor_hover
    })
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
