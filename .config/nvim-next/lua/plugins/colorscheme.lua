return {
    {
        "folke/tokyonight.nvim",
        lazy = true,
        config = function()
            require("tokyonight").setup({
                styles = {
                    comments = { italic = false },
                },
            })
        end,
    },
    {
        "Skardyy/makurai-nvim",
        lazy = true,
        config = function()
            require("makurai").setup({
                transparent = false,
            })
        end,
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        functions = "italic,bold",
                        types = "italic",
                    },
                },
            })
        end,
    },
    { "rktjmp/lush.nvim", lazy = true },
    { "catppuccin/nvim", lazy = true, name = "catppuccin" },
    { "neanias/everforest-nvim", lazy = true },
    { "Everblush/everblush.nvim", lazy = true },
    {
        "Aejkatappaja/sora",
        lazy = true,
        opts = {},
    },
}
