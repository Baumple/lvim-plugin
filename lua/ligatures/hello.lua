local M = {
  custom_word_map = {
    { "o", "0" }
  }
}

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

local word_replace_map = {
  { "->", "→", },
  { "=>", "⇒" }
}

local function join_tables(t1, t2)
  for i = 1, #t2 do
    table.insert(t1, t2[i])
  end
end

---Converts ligeraturs in current line
function M.lig_line()
  local line = api.nvim_get_current_line()
  local word_repl_map = join_tables(word_replace_map, M.custom_word_map)
  for i = 1, #word_replace_map do
    line = line.gsub(line, word_replace_map[i][1], word_replace_map[i][2])
  end

  local r, _ = unpack(api.nvim_win_get_cursor(0))

  replace_line(line, r)
  vim.api.nvim_buf_set_lines(0, r - 1, r, false, { line })
end

function M.lig_word()
  local r, _ = unpack(api.nvim_win_get_cursor(0))
  local line = api.nvim_get_current_line()

  for i = 1, #word_replace_map do
    if string.find(line, word_replace_map[i][1]) then
      line = string.gsub(line, word_replace_map[i][1], word_replace_map[i][2], 1)
      break
    end
  end
  replace_line(line, r)
end

-- -> --=>
return M
