return {
	"kiddos/gemini.nvim",
	dependencies = {
		-- Optional: If you want completion suggestions with nvim-cmp
		-- { 'hrsh7th/nvim-cmp' },
		-- { 'hrsh7th/cmp-nvim-lsp' },
	},
	opts = {
		-- Default settings (you can customize these)
		model_config = {
			completion_delay = 1000, -- Delay in ms before showing completion results
			model_id = "gemini-2.5-flash", -- or 'gemini-1.5-pro', 'gemini-pro', etc.
			temperature = 0.2,
			top_k = 20,
			max_output_tokens = 8196,
			response_mime_type = "text/plain",
		},
		chat_config = {
			enabled = true,
		},
		hints = {
			enabled = true,
			hints_delay = 2000,
			insert_result_key = "<S-Tab>", -- Key to insert hint result
			-- You can customize get_prompt here
		},
		completion = {
			-- Customize how completion prompts are generated
		},
		instruction = {
			enabled = true,
			menu_key = "<C-o>", -- Key to open instruction menu
			prompts = {
				-- Default prompts (Unit Test, Code Review, Code Explain)
				-- You can add your own custom prompts here
			},
		},
		task = {
			enabled = true,
			-- Customize get_system_text and get_prompt for task mode
		},
	},
	-- Optional: Keymaps for convenience
	keys = {
		-- Instruction mode (e.g., for Code Review, Unit Test)
		{ "<leader>ai", "<cmd>GeminiInstruction<CR>", desc = "Gemini: Instruction Menu" },
		-- Chat mode
		{ "<leader>ac", "<cmd>GeminiChat<CR>", desc = "Gemini: Chat" },
		-- Task mode
		{ "<leader>at", "<cmd>GeminiTask<CR>", desc = "Gemini: Task" },
		-- Completion (if you're not using nvim-cmp or want a direct trigger)
		-- { "<leader>gg", "<cmd>GeminiCompletion<CR>", desc = "Gemini: Complete" },
	},
}
