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
                layout_config = {
                    height = 0.5
                }
            },
            pickers = {
                live_grep = {
                    additional_args = {
                        "--no-ignore",
                        "--hidden"
                    }
                },
                find_files = {
                    find_command = {
                        "fd",
                        "--type", "f",
                        "--hidden",
                        "--follow",
                        "--no-ignore",
                    }
                }
            }
        }
    end
}
