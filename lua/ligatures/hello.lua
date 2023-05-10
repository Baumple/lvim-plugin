local M = {}

local api = vim.api

---Replaces a line at given row with the text
---@param line_text string
---@param row integer
local function replace_line(line_text, row)
  api.nvim_buf_set_lines(0, row - 1, row, false, { line_text })
end

function M.test()
  print(M.lig_line)
  print(M.lig_word)
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
function M.lig_line()
  local line = api.nvim_get_current_line()

  for i = 1, #ligature_symbol.ligatures do
    line = line.gsub(line, ligature_symbol.ligatures[i], ligature_symbol.symbols[i])
  end

  local r, _ = unpack(api.nvim_win_get_cursor(0))

  replace_line(line, r)
  vim.api.nvim_buf_set_lines(0, r - 1, r, false, { line })
end

function M.lig_word()
  local r, _ = unpack(api.nvim_win_get_cursor(0))
  local line = api.nvim_get_current_line()

  for i = 1, #ligature_symbol.ligatures do
    if string.find(line, ligature_symbol.ligatures[i]) then
      line = string.gsub(line, ligature_symbol.ligatures[i], ligature_symbol.symbols[i], 1)
      break
    end
  end
  replace_line(line, r)
end

return M
