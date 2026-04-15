local map = vim.keymap.set
local fzf = require("fzf-lua")

-- Clear search highlighting when pressing Esc in normal mode
map("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Insert mode navigation
map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })
map("i", "<C-d>", "<BS>", { desc = "backspace" })
-- map("i", "jk", "<ESC>")
-- map("i", "kj", "<ESC>")

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- Formatting
map({ "n", "x" }, "<leader>fm", function()
    require("conform").format({ lsp_fallback = true })
end, { desc = "Format file" })

-- LSP mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP rename" })
map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- LSP navigation (fzf-lua)
map("n", "grr", fzf.lsp_references, { desc = "LSP References" })
map("n", "gd", fzf.lsp_definitions, { desc = "LSP Definitions" })
map("n", "gi", vim.lsp.buf.declaration, { desc = "LSP Declaration" })
map("n", "gW", fzf.lsp_workspace_symbols, { desc = "Workspace Symbols" })
map("n", "grt", fzf.lsp_typedefs, { desc = "LSP Type Definitions" })
map("n", "<leader>ss", fzf.lsp_document_symbols, { desc = "LSP Symbols (current file)" })

-- Find (fzf-lua)
map("n", "<leader>ff", fzf.files, { desc = "Find files" })
map("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
map("n", "<leader>fo", fzf.oldfiles, { desc = "Recent files" })
map("n", "<leader>fh", fzf.helptags, { desc = "Find help" })
map("n", "<leader>fk", fzf.keymaps, { desc = "Find keymaps" })
map("n", "<leader>fd", fzf.diagnostics_document, { desc = "Find diagnostics" })
map("n", "<leader>fr", fzf.resume, { desc = "Resume last search" })
map("n", "<leader>fc", fzf.grep_cword, { desc = "Find current word" })
map("n", ";", fzf.command_history, { desc = "Command history" })

map("n", "<leader>fa", function()
    fzf.files({ cwd = vim.env.HOME })
end, { desc = "Find all files from home" })

map("n", "<leader>f/", function()
    fzf.live_grep({ grep_open_files = true })
end, { desc = "Grep in open files" })

map("n", "<leader>fn", function()
    fzf.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Find Neovim files" })

map("n", "<leader>/", fzf.blines, { desc = "Fuzzy search in current buffer" })

-- Colorscheme picker (fzf-lua)
local default_vim_schemes = {
    "blue", "lunaperche", "darkblue", "delek", "desert", "elflord", "evening",
    "industry", "koehler", "morning", "murphy", "pablo", "peachpuff", "ron",
    "shine", "slate", "torte", "zellner", "unokai", "zaibatsu", "vim",
    "wildcharm", "sorbet", "retrobox", "quiet", "randomhue", "habamax",
}

map("n", "<leader>th", function()
    fzf.colorschemes({
        ignore_patterns = default_vim_schemes,
    })
end, { desc = "Pick colorscheme" })

map("n", "<leader>ld", function()
    if vim.o.background == "light" then
        vim.o.background = "dark"
    else
        vim.o.background = "light"
    end
end, { desc = "Toggle light/dark background" })

-- Git
map("n", "<leader>gp", function()
    require("gitsigns").preview_hunk()
end, { desc = "Gitsigns preview hunk" })

map("n", "<leader>gcm", function()
    local branches = vim.fn.systemlist("git branch --list main master")
    if vim.tbl_contains(branches, "  main") then
        vim.cmd("Git checkout main")
    elseif vim.tbl_contains(branches, "  master") then
        vim.cmd("Git checkout master")
    else
        print("Neither 'main' nor 'master' branch found.")
    end
end, { noremap = true, silent = true, desc = "Git checkout main/master" })

map("n", "<leader>gcb", function()
    local branch_name = vim.fn.input("New branch name (prefix 'dev-'): ", "dev-")
    if branch_name ~= "" then
        vim.cmd("Git checkout -b " .. branch_name)
    end
end, { noremap = true, silent = true, desc = "Git checkout new dev-* branch" })

map("n", "<leader>gco", fzf.git_branches, { desc = "Git checkout branch" })

-- Quickfix / loclist navigation
map("n", "<M-j>", function()
    if vim.fn.getloclist(0, { size = 0 }).size > 0 then
        vim.cmd("lnext")
    elseif vim.fn.getqflist({ size = 0 }).size > 0 then
        vim.cmd("cnext")
    end
end, { noremap = true, silent = true, desc = "Next quickfix/loclist" })

map("n", "<M-k>", function()
    if vim.fn.getloclist(0, { size = 0 }).size > 0 then
        vim.cmd("lprev")
    elseif vim.fn.getqflist({ size = 0 }).size > 0 then
        vim.cmd("cprev")
    end
end, { noremap = true, silent = true, desc = "Prev quickfix/loclist" })

-- Buffer management (barbar)
map("n", "<Tab>", function()
    require("barbar.api").goto_buffer_relative(1)
end)
map("n", "<S-Tab>", function()
    require("barbar.api").goto_buffer_relative(-1)
end)
map("n", "<leader>x", ":BufferClose<CR>")
map("n", "<leader>gq", ":q<CR>", { desc = "Close window" })

-- Leap
map({ "n", "x", "o" }, "f", "<Plug>(leap-forward)")
map({ "n", "x", "o" }, "F", "<Plug>(leap-backward)")

-- Pyright organize imports
map(
    "n",
    "<leader>oi",
    "<cmd>lua vim.lsp.buf.execute_command({ command = '_pyright.organizeimports', arguments = {vim.api.nvim_buf_get_name(0)} })<CR>",
    { noremap = true, silent = true, desc = "Organize imports (pyright)" }
)

-- Grug-far (search and replace)
map({ "n", "x" }, "<leader>ar", function()
    require("grug-far").open({
        prefills = { search = vim.fn.expand("<cword>") },
    })
end, { desc = "Grug far on cursor word" })

map({ "n", "x" }, "<leader>as", function()
    local search = vim.fn.getreg("/")
    if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
        search = "\\b" .. search:sub(3, -3) .. "\\b"
    end
    require("grug-far").open({
        prefills = { search = search },
    })
end, { desc = "Grug-far: search from @/ register" })

-- Markdown preview
map("n", "<leader>mp", ":PeekOpen<CR>", { desc = "Open Readme file" })

-- MiniNotify
map("n", "<leader>on", function()
    require("mini.notify").show_history()
end, { desc = "Show MiniNotify history" })

-- Reverse selection
map("v", "<leader>rv", "!tac<CR>", { noremap = true, silent = true, desc = "Reverse selected text" })

-- Debugging (lazy require to avoid load-time errors)
-- map("n", "<leader>dc", function() require("dap").continue() end, { desc = "Start/Continue Debugging" })
-- map("n", "<leader>do", function() require("dap").step_over() end, { desc = "Step Over" })
-- map("n", "<leader>di", function() require("dap").step_into() end, { desc = "Step Into" })
-- map("n", "<leader>dO", function() require("dap").step_out() end, { desc = "Step Out" })
-- map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
-- map("n", "<leader>dB", function()
--     require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
-- end, { desc = "Set Conditional Breakpoint" })
-- map("n", "<leader>7", function()
--     require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
-- end, { desc = "Set Log Point" })
-- map("n", "<leader>8", function() require("dap").terminate() end, { desc = "Terminate Debugging" })
-- map("n", "<leader>9", function() require("dap").restart() end, { desc = "Restart Debugging" })
-- map({ "n", "v" }, "<leader>dt", function()
--     require("dap-python").test_method()
-- end, { desc = "Debug nearest test" })
-- map({ "n", "v" }, "<leader>dr", function()
--     require("dapui").open({ reset = true })
-- end, { desc = "Reload debugger UI" })

-- Terminal
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        map("t", "<C-n>", [[<C-\><C-n>]], { buffer = true, desc = "Exit terminal mode" })
    end,
})
