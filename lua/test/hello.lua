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
  local api = vim.api
  local line = api.nvim_get_current_line()

  for i = 1, #ligature_symbol.ligatures do
    line = line.gsub(line, ligature_symbol.ligatures[i], ligature_symbol.symbols[i])
  end


  local r, c = unpack(api.nvim_win_get_cursor(0))

  vim.api.nvim_buf_set_lines(0, r - 1, r, false, { line })
end

return M
