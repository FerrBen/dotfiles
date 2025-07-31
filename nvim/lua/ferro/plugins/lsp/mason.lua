-- Ensure this file is placed in your Neovim configuration,
-- for example: lua/plugins/mason.lua (if using lazy.nvim structure)

return {
	"williamboman/mason.nvim",
	lazy = false, -- Or true if you prefer, but ensure it's loaded before LSP configs
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"neovim/nvim-lspconfig",
		-- "saghen/blink.cmp",
	},
	config = function()
		-- import mason and mason_lspconfig
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp") -- import cmp-nvim-lsp plugin

		-- Define capabilities. This should ideally be defined once and reused.
		-- Ensure cmp_nvim_lsp is loaded and configured before this.
		local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
		-- If you are not using nvim-cmp, you might use:
		-- local capabilities = vim.lsp.protocol.make_client_capabilities()

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- servers for mason to install
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"html",
				"cssls",
				"astro",
				"marksman",
				"mdx_analyzer",
				"tailwindcss",
				"gopls",
				"emmet_ls",
				-- "emmet_language_server", -- emmet_ls is generally preferred and more standard
				-- "eslint", -- eslint is often run via null-ls or a dedicated linting plugin
				"marksman",
				"prismals",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"pylint",
				"markdownlint-cli2",
				"clangd", -- C/C++/Objective-C LSP
				-- "denols", -- Deno LSP, uncomment if needed
				{ "eslint_d", version = "13.1.2" }, -- ESLint daemon
				-- "eslint_d",
			},
			handlers = {
				-- Default handler for all servers that don't have a custom handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						-- You might want to add a default on_attach here if you have one
						-- on_attach = your_global_on_attach_function,
					})
				end,

				-- Custom handler for lua_ls with refined settings
				["lua_ls"] = function()
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = {
									-- Tell the language server which version of Lua you're using (most likely LuaJIT for Neovim)
									version = "LuaJIT",
								},
								diagnostics = {
									-- Get the language server to recognize the `vim` global
									globals = { "vim" },
								},
								workspace = {
									-- Make the server aware of Neovim runtime files.
									-- This is generally more robust and recommended.
									library = vim.api.nvim_get_runtime_file("", true),
									-- This setting can help reduce noise from third-party code/plugins.
									checkThirdParty = false,
								},
								completion = {
									callSnippet = "Replace", -- Your existing completion setting
								},
								telemetry = {
									enable = false, -- Optional: Disable telemetry
								},
							},
						},
						-- on_attach = your_lua_specific_on_attach_function, -- If needed
					})
				end,

				-- Custom handler for emmet_ls
				["emmet_ls"] = function()
					lspconfig.emmet_ls.setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
							"astro", -- Added Astro as an example
							"vue", -- Added Vue
						},
					})
				end,

				-- NOTE: emmet_language_server is often an older or alternative emmet LSP.
				-- emmet_ls is generally the more standard one to use.
				-- If you specifically need emmet_language_server, you can keep its handler.
				-- Otherwise, you might not need it if emmet_ls covers your needs.
				["emmet_language_server"] = function()
					lspconfig.emmet_language_server.setup({
						capabilities = capabilities, -- Added capabilities here as well
						filetypes = {
							"css",
							"eruby",
							"html",
							"javascript",
							"javascriptreact",
							"less",
							"sass",
							"scss",
							"pug",
							"typescriptreact",
						},
						init_options = {
							includeLanguages = {},
							excludeLanguages = {},
							extensionsPath = {},
							preferences = {},
							showAbbreviationSuggestions = true,
							showExpandedAbbreviation = "always",
							showSuggestionsAsSnippets = false,
							syntaxProfiles = {},
							variables = {},
						},
					})
				end,

				-- Custom handler for tsserver (typescript-language-server)
				["tsserver"] = function()
					lspconfig.tsserver.setup({
						capabilities = capabilities,
						-- Example root_dir logic to prefer tsconfig.json etc.
						-- Adjust if you use Deno primarily for TypeScript.
						root_dir = lspconfig.util.root_pattern(
							"tsconfig.json",
							"package.json",
							"jsconfig.json",
							".git"
						),
						single_file_support = true, -- Often true is fine for tsserver
						init_options = {
							preferences = {
								includeCompletionsWithSnippetText = true,
								includeCompletionsForImportStatements = true,
								includeAutomaticOptionalChainCompletions = true, -- Example of another preference
							},
						},
						-- on_attach = your_typescript_specific_on_attach_function, -- If needed
					})
				end,

				-- Custom handler for denols (if you decide to use it)
				-- ["denols"] = function()
				--   lspconfig.denols.setup({
				--     capabilities = capabilities,
				--     root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
				--     init_options = {
				--       lint = true,
				--       unstable = true, -- Or false, depending on your needs
				--     }
				--   })
				-- end,
			},
		})
	end,
}
