return {
    "coffebar/neovim-project",
    opts = {
        projects = { -- define project roots
            "~/codes/*",
            "~/.config/nvim/*"
        },
        picker = {
            type = "telescope", -- one of "telescope", "fzf-lua", or "snacks"
        },
        -- Load the most recent session on startup if not in the project directory
        last_session_on_startup = false,
        -- Dashboard mode prevent session autoload on startup
        dashboard_mode = true,
    },
    init = function()
        -- enable saving the state of plugins in the session
        vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
    end,
    dependencies = {
        { "nvim-lua/plenary.nvim" },
        { "nvim-telescope/telescope.nvim" },
        { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
}
