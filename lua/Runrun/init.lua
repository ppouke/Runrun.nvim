local M = {}

local Path = require("plenary.path")
M.ui = require("Runrun.ui")
M.config = require("Runrun.config")


local configPath = vim.fn.stdpath("config")
local dataPath = vim.fn.stdpath("data")
local userConfig = string.format("%s/runrun.json", configPath)
local cacheConfig = string.format("%s/runrun.json", dataPath)

M.runEditor = function()
  M.ui.toggleMenu()
end

M.runCommand = function(index)
  print("run command at ",index)
end


local function readConfig(localConfig)
  return vim.json.decode(Path:new(localConfig):read())
end

-- TODO add config stuff
function M.setup(config)
  if not config then
    config = {}
  end

  local ok, u_config = pcall(readConfig, userConfig)
  
  if not ok then
    print("No user config present at", userConfig)
    u_config = {}
  end
end

return M
