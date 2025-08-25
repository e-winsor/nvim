-- ================================================================================================
-- TITLE : which-key
-- ABOUT : WhichKey helps your remember your NeoVim keymaps, by showing keybindings as you type
-- LINKS : https://github.com/folke/which-key.nvim
-- ================================================================================================

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}

