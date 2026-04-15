local function run_current_file()
    local file = vim.fn.expand("%:p")
    if file == "" then
        vim.notify("No file to run", vim.log.levels.WARN)
        return
    end

    local ft = vim.bo.filetype
    local runner = {
        python = "python3",
        bash = "bash",
        sh = "bash",
        lua = "lua",
        javascript = "node",
        c = nil, -- handled separately
    }

    if ft == "c" then
        local out = file:gsub("%.c$", "")
        local args = vim.fn.input("Args: ")
        vim.cmd("split | resize 15 | terminal gcc -o " .. out .. " " .. file .. " && " .. out .. " " .. args)
        vim.cmd("startinsert")
        return
    end

    local bin = runner[ft]
    if not bin then
        vim.notify("No runner for filetype: " .. ft, vim.log.levels.WARN)
        return
    end

    local args = vim.fn.input("Args: ")
    vim.cmd("split | resize 15 | terminal " .. bin .. " " .. file .. " " .. args)
    vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>rf", run_current_file, {
  desc = "Run current file in terminal",
})
