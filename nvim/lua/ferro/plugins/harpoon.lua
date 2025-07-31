return {
	"thePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local harpoon = require("harpoon")
		local conf = require("telescope.config").values

		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		-- NOTE: Experimenting
		-- Telescope into Harpoon function
		-- comment this function if you don't like it
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>ha", function()
			harpoon:list():add()
		end, { desc = "Harpoon add file" })
		vim.keymap.set("n", "<leader>hh", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Harpoon Quick Menu" })

		--Harpoon marked files
		vim.keymap.set("n", "<C-1>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-2>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-3>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-4>", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<C-5>", function()
			harpoon:list():select(5)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>hp", function()
			harpoon:list():prev()
		end, { desc = "Harpoon Prev" })
		vim.keymap.set("n", "<leader>hn", function()
			harpoon:list():next()
		end, { desc = "Harpoon Next" })

		-- Telescope inside Harpoon Window
		vim.keymap.set("n", "<leader>hf", function()
			toggle_telescope(harpoon:list())
		end, { desc = "Harpoon inside Telescope" })
	end,
}
