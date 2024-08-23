-- local runrun = require("Runrun")
local popup = require("plenary.popup")
local config = require("Runrun.config")

local M = {}
local runWinID = nil
local runBufh = nil

local function createWindow()
  local width = 60
  local height = 10
  local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  local bufnr = vim.api.nvim_create_buf(false, false)

  local winID, win = popup.create(bufnr, {
    title = "Runrun",
    highlight = "RunrunWindow",
    line = math.floor(((vim.o.lines - height) / 2) - 1),
    col = math.floor((vim.o.columns - width) / 2),
    minwidth = width,
    minheight = height,
    borderchars = borderchars
  })

  vim.api.nvim_win_set_option(
    win.border.win_id,
    "winhl",
    "Normal:RunrunBorder"
  )

  return {
    bufnr = bufnr,
    win_id = winID,
  }
end

-- local function isWhiteSpace(str)
--   return str:gsub("%s", "") == ""
-- end

local function getList()
  local lines = vim.api.nvim_buf_get_lines(runBufh, 0, -1, true)
  local indices = {}

  for _, line in ipairs(lines) do
    -- if not isWhiteSpace(line) then
    table.insert(indices, line)
    -- end
  end

  return indices
end

function M.save()
  local list = getList()
  config.setList(list)
end

function M.closeMenu()
  M.save()
  vim.api.nvim_win_close(runWinID, true)
  runWinID = nil
  runBufh = nil
end

M.toggleMenu = function()
  if runWinID ~= nil and vim.api.nvim_win_is_valid(runWinID) then
    M.closeMenu()
    return
  end

  local win_info = createWindow()
  local contents = config.readConfig()


  runWinID = win_info.win_id
  runBufh = win_info.bufnr
  vim.api.nvim_win_set_option(runWinID, "number", true)
  vim.api.nvim_buf_set_lines(runBufh, 0, #contents, false, contents)
  vim.api.nvim_buf_set_option(runBufh,"bufhidden", "delete")
  vim.api.nvim_buf_set_option(runBufh,"buftype", "acwrite")
  vim.api.nvim_buf_set_keymap(runBufh, "n", "q", "<Cmd>lua require('Runrun.ui').toggleMenu()<CR>", {silent = true})
  vim.cmd(
    string.format(
      "autocmd BufWriteCmd <buffer=%s> lua require('Runrun.ui').save()",
        runBufh
    )
  )
  vim.cmd(
    string.format(
      "autocmd BufLeave <buffer> ++nested ++once lua require('Runrun.ui').toggleMenu()"
    )
  )
end

return M
