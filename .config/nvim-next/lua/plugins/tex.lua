return {
    {
        "lervag/vimtex",
        ft = "markdown",
        opts_extend = {},
        init = function()
            vim.g.vimtex_view_method = "zathura"
        end,
    },
}
