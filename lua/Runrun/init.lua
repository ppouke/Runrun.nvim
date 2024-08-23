local popup = require("plenary.popup")
local ui = require("Runrun.ui")
local config = require("Runrun.config")

local M = {}

M.runEditor = function()
  ui.toggleMenu()
end

M.runCommand = function(index)
  local command = config.listAt(index)
  if command == nil then
    print("Runrun: no command at index", index)
    return
  end
  vim.cmd(
    string.format(
      "!%s", command
    )
  )
end

M.runTerminal = function(index)
  --  TODO FIX THIS

  vim.cmd(string.format(":15split"))
  local command = config.listAt(index)
  vim.cmd(
    string.format(
    ":term %s", command
    ))

end


return M
