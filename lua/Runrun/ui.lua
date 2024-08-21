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

local function close_menu()
  vim.api.nvim_win_close(runWinID, true)
  runWinID = nil
  runBufh = nil
end


M.toggleMenu = function()
  if runWinID ~= nil and vim.api.nvim_win_is_valid(runWinID) then
    close_menu()
    return
  end

  local win_info = createWindow()
  local contents = {}

  runWinID = win_info.win_id
  runBufh = win_info.bufnr
  vim.api.nvim_win_set_option(runWinID, "number", true)
  vim.api.nvim_buf_set_lines(runBufh, 0, 4, false, {})
end


return M
