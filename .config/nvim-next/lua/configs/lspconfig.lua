require("mason-tool-installer").setup({
    ensure_installed = {
        "lua-language-server",
        "clangd",
        "bashls",
        "shellcheck",
        "shfmt",
        "debugpy",
        "basedpyright",
        "ruff",
        "stylua",
        "marksman",
        "markdownlint",
        "yaml-language-server",
        "texlab",
        "jsonls",
        "dockerls",
        "docker_compose_language_service",
    },
})

local servers = {
    "bashls",
    "basedpyright",
    "clangd",
    "dockerls",
    "docker_compose_language_service",
    "jsonls",
    "lua_ls",
    "marksman",
    "texlab",
    "yamlls",
    "ruff",
}

vim.lsp.config("marksman", {
    filetypes = { "md", "markdown", "mdx", "markdown.mdx" },
})

vim.lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed",
        "--header-insertion=never",
    },
    filetypes = { "c", "cpp", "objc", "objcpp" },
})

vim.lsp.config("yamlls", {
    filetypes = { "yaml", "yml" },
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/compose-spec/compose-go/master/schema/compose-spec.json"] = {
                    "docker-compose.yml",
                    "docker-compose.yaml",
                    "**/docker-compose*.yml",
                    "**/docker-compose*.yaml",
                    "compose.yml",
                    "compose.yaml",
                },
                ["https://json.schemastore.org/azure-pipelines.json"] = {
                    "azure-pipelines.yml",
                    "azure-pipelines.yaml",
                    "*pipeline*.yml",
                    "*pipeline*.yaml",
                },
            },
            validate = true,
            hover = true,
            completion = true,
            format = { enable = true },
        },
    },
})

for _, lsp in ipairs(servers) do
    vim.lsp.enable(lsp)
end
