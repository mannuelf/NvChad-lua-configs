local vim = vim
local lspconfig = require("lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local null_ls = require "null-ls"

local function organize_imports()
	local params = {
		command = "_typescript.organizeImports",
		arguments = { vim.api.nvim_buf_get_name(0) },
	}
	vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	init_options = {
		preferences = {
			disableSuggestions = true,
		},
	},
	commands = {
		OrganizeImports = {
			organize_imports,
			description = "Organize Imports",
		},
	},
})

lspconfig.svelte.setup {
	on_attach = function(client, bufnr)
		null_ls.setup {
			on_attach = function()
				client.resolved_capabilities.document_formatting = true
				client.resolved_capabilities.document_range_formatting = true
			end,
		}
	end,
}

lspconfig.denols.setup {
	on_attach = function(client, bufnr)
		-- Disable tsserver for Deno projects
		if client.name == "tsserver" then
			client.stop()
		end
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
	init_options = {
		lint = true,
		unstable = true,
	},
}

lspconfig.tsserver.setup {
	on_attach = function(client, bufnr)
		if lspconfig.util.root_pattern("deno.json", "deno.jsonc")(vim.fn.getcwd()) then
			client.stop()
		else
			on_attach(client, bufnr)
		end
	end,
	capabilities = capabilities,
}

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "clangd" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end
