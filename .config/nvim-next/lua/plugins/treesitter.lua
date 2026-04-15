return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    config = function()
        require("nvim-treesitter").setup({})

        require("nvim-treesitter").install({
            "c",
            "cpp",
            "cmake",
            "ini",
            "vim",
            "lua",
            "vimdoc",
            "kotlin",
            "python",
            "javascript",
            "typescript",
            "yaml",
            "json",
            "bash",
            "html",
            "css",
            "markdown",
            "markdown_inline",
            "tsx",
        })

        vim.api.nvim_create_autocmd("FileType", {
            callback = function()
                pcall(vim.treesitter.start)
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
