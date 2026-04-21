local options = {
    formatters_by_ft = {
        lua = { "stylua" },
        css = { "prettier" },
        html = { "prettier" },
        python = { "ruff_format" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        typescript = { "biome" },
        typescriptreact = { "biome" },
        sh = { "shfmt" },
        bash = { "shfmt" },
    },
    formatters = {
        ruff_format = {
            command = "ruff",
            args = { "format", "-" },
            stdin = true,
        },
        shfmt = {
            prepend_args = { "-i", "4", "-ci", "-bn" },
        },
    },
}

return options
