local popup = require("plenary.popup")
local ui = require("Runrun.ui")
local config = require("Runrun.config")

local M = {}

M.runEditor = function()
  ui.toggleMenu()
end

M.runCommand = function(index)
  local command = config.listAt(index)
  vim.cmd(
    string.format(
      "!%s", command
    )
  )
end

M.runTerminal = function(index)
  --  TODO FIX THIS
  -- local width = 60
  -- local height = 10
  -- local borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
  --
  -- local bufnr = vim.api.nvim_create_buf(false, false)
  --
  -- local winID, win = popup.create(bufnr, {
  --   title = "Runrun",
  --   highlight = "RunrunWindow",
  --   line = math.floor(((vim.o.lines - height) / 2) - 1),
  --   col = math.floor((vim.o.columns - width) / 2),
  --   minwidth = width,
  --   minheight = height,
  --   borderchars = borderchars
  -- })
  --
  -- vim.api.nvim_win_set_option(
  --   win.border.win_id,
  --   "winhl",
  --   "Normal:RunrunBorder"
  -- )
  -- local term = vim.api.nvim_open_term(bufnr, {})
  --
  -- local command = config.listAt(index)
  -- local termCommand = string.format("%s<CR>", command)
  -- termCommand = vim.api.nvim_replace_termcodes(termCommand, true, true, true)
  --
  -- vim.api.nvim_chan_send(term, termCommand)
end


return M
