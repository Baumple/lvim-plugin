local M = {}

function M.test()
  print("Hello, world")
end

local ligature_symbol = {
  ligatures = {
    "->",
    "=>",

  },
  symbols = {
    "→",
    "⇒"
  }
}

---Converts ligeraturs in current line
function M.ligatures()
  local line = vim.api.nvim_get_current_line()

  for i = 1, #ligature_symbol.ligatures do
    print(ligature_symbol.ligatures[i])
    print(ligature_symbol.symbols[i])
    line = line.gsub(line, ligature_symbol.ligatures[i], ligature_symbol.symbols[i])
  end

  local api = vim.api

  local r, c = unpack(api.nvim_win_get_cursor(0))

  print(line)
  print("r: " .. r)
  print("c: " .. c)

  vim.api.nvim_buf_set_lines(0, r - 1, r, false, { line })
end

return M
