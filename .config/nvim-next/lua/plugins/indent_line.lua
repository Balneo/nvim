return {
    { -- Add indentation guides even on blank lines
        "lukas-reineke/indent-blankline.nvim",
        -- Enable `lukas-reineke/indent-blankline.nvim`
        -- See `:help ibl`
        main = "ibl",
        event = "BufReadPost",
        opts = {
            exclude = {
                filetypes = { "dashboard", "help", "startify", "lazy", "mason", "neo-tree" },
            },
        },
    },
}
