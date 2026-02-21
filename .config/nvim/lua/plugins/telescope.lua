return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        require('telescope').setup {
            defaults = require('telescope.themes').get_ivy {
                initial_mode = "insert",
                mappings = {
                    i = {
                        -- Press ESC in insert mode to close Telescope
                        ["<Esc>"] = require('telescope.actions').close,
                    }
                },
                layout_config = {
                    height = 0.35,
                    preview_cutoff = 9999999,
                }
            },
            pickers = {
                live_grep = {
                    additional_args = {
                        "--hidden",
                        "--glob",
                        "!**/.git/*"
                    }
                },
                find_files = {
                    find_command = {
                        "fd",
                        "--type", "f",
                        "--type", "d",
                        "--hidden",
                        "--follow",
                        "--exclude", ".git"
                    }
                }
            }
        }
    end
}
