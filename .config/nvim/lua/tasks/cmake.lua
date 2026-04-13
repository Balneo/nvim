local overseer = require("overseer")

local last_cmd = "minigrep hello src"

overseer.register_template({
  name = "CMake Build & Run",
  condition = {
    filetype = { "c" },
  },
  builder = function()
    local cmd = vim.fn.input("Run: ./build/", last_cmd)
    last_cmd = cmd
    return {
      cmd = { "sh" },
      args = { "-c", "cmake --build build && ./build/" .. cmd },
      cwd = vim.fn.getcwd(),
      components = {
        { "on_output_quickfix", open = true },
        "default",
      },
    }
  end,
})
