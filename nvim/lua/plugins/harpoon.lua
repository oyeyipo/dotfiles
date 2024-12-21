return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	event = "VimEnter",
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		harpoon:setup()

		local map = function(key, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, key, func, { desc = "Harpoon: " .. desc })
		end

		map("<leader>a", function()
			harpoon:list():add()
		end, "[a]dd buffer")
		map("<leader>A", function()
			harpoon:list():prepend()
		end, "[A] Prepend buffer")
		map("<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, "Toggl[e] quick menu")

		map("<leader>1", function()
			harpoon:list():select(1)
		end, "Select buffer [1]")
		map("<leader>2", function()
			harpoon:list():select(2)
		end, "Select buffer [2]")
		map("<leader>3", function()
			harpoon:list():select(3)
		end, "Select buffer [3]")
		map("<leader>4", function()
			harpoon:list():select(4)
		end, "Select buffer [4]")
		map("<leader>r1", function()
			harpoon:list():replace_at(1)
		end, "[R]eplace buffer at [1]")
		map("<leader>r2", function()
			harpoon:list():replace_at(2)
		end, "[R]eplace buffer at [2]")
		map("<leader>r3", function()
			harpoon:list():replace_at(3)
		end, "[R]eplace buffer at [3]")
		map("<leader>r4", function()
			harpoon:list():replace_at(4)
		end, "[R]eplace buffer at [4]")

		-- Toggle previous & next buffers stored within Harpoon list
		map("<leader>p", function()
			harpoon:list():prev()
		end, "[P]revious buffer")
		map("<leader>n", function()
			harpoon:list():next()
		end, "[N]ext buffer")
	end,
}
