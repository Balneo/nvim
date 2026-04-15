vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    callback = function()
        vim.keymap.set({ "n", "v" }, "<CR>", function()
            require("kulala").run()
        end, { desc = "Send request (Kulala)", buffer = true })
    end,
})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf

        vim.keymap.set("n", "<leader>ih", function()
            local enabled = vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(not enabled)
        end, { buffer = bufnr, desc = "Toggle Inlay Hints" })

        vim.keymap.set({ "n", "v" }, "<leader>ca", function()
            require("actions-preview").code_actions()
        end, { buffer = bufnr, desc = "Code Actions" })
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = function()
        vim.cmd([[
		highlight! link Pmenu Normal
		highlight! link PmenuSel Visual
		highlight! link PmenuThumb Normal
		highlight! link NormalFloat Normal
		highlight! link FloatBorder Normal
		highlight! link CmpItemKindFunction Function
		highlight! link CmpItemKindVariable Identifier
		highlight! link CmpItemKindKeyword Keyword
		]])
    end,
})

-- Return cursor to last position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end,
    desc = "Restore cursor position",
})

vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        -- Remove trailing whitespace
        vim.cmd([[%s/\s\+$//e]])
        -- Remove trailing blank lines at end of file
        vim.cmd([[silent! %s/\n\+\%$//e]])
        vim.api.nvim_win_set_cursor(0, pos)
    end,
    desc = "Clean trailing whitespace and blank lines on save",
})

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank({ timeout = 150 })
    end,
    desc = "Highlight on yank",
})
