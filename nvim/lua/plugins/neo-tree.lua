return {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", 
      "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                position = "right",
                width = 40,
            },
            filesystem = {
                filtered_items = {
                    visible = false, -- when true, they will just be displayed differently than normal items
                    hide_dotfiles = false,
                    hide_gitignored = false,
                    hide_hidden = false, -- only works on Windows for hidden files/directories
                },
            },
        })
    end
}
--[[
    nnoremap / :Neotree toggle current reveal_force_cwd<cr>
    nnoremap | :Neotree reveal<cr>
    nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr>
    nnoremap <leader>b :Neotree toggle show buffers right<cr>
    nnoremap <leader>s :Neotree float git_status<cr>
--]]

