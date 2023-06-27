require("ligatures.util")
local M = {
  word_replace_map = {
    { "->", "→", },
    { "=>", "⇒" },
  },
  custom_word_map = nil
}

local function dbg(x)
  print("'" .. dump(x) .. "'")
  return x
end

local api = vim.api

---Replaces a line at given row with the text
---@param line_text string
---@param row integer
local function replace_line(line_text, row)
  api.nvim_buf_set_lines(0, row - 1, row, false, { line_text })
end

function M.dbg()
  print(dump(M))
end

function M:join_maps()
  if not self.custom_word_map then
    return
  end
  for i = 1, #self.custom_word_map do
    table.insert(self.word_replace_map, self.custom_word_map[i])
  end
  self.custom_word_map = nil

  table.sort(self.word_replace_map, function(a, b)
    return a[1]:len() > b[1]:len()
  end)
end

---Converts ligeraturs in current line
function M.lig_line(lines)
  local line = api.nvim_get_current_line()

  M:join_maps()

  for i = 1, #M.word_replace_map do
    line = string.gsub(line, M.word_replace_map[i][1],
      M.word_replace_map[i][2])
  end

  local r, _ = unpack(api.nvim_win_get_cursor(0))

  replace_line(line, r)
  vim.api.nvim_buf_set_lines(0, r - 1, r, false, { line })
end

function M.lig_lines(lines)
  print(dump(lines))
end

function M.lig_word()
  local r, _ = unpack(api.nvim_win_get_cursor(0))
  local line = api.nvim_get_current_line()

  M:join_maps()

  for i = 1, #M.word_replace_map do
    if string.find(line, M.word_replace_map[i][1]) ~= nil then
      print(M.word_replace_map[i][1])
      line = string.gsub(line, M.word_replace_map[i][1],
        1)
      break
    end
  end
  replace_line(line, r)
end

return M
