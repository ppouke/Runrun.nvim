local Path = require("plenary.path")
local configPath = vim.fn.stdpath("data")
local userConfig = string.format("%s/runrun.json", configPath)

local M = {}
local runConfig = {}
local function decodeJson(localConfig)
  return vim.json.decode(Path:new(localConfig):read())
end

local function saveConfig()
  Path:new(userConfig):write(vim.fn.json_encode(runConfig), "w")
end

function M.readConfig()
  local ok, config = pcall(decodeJson, userConfig)
  if not ok then
    print("existing config not found")
    return {}
  end
  return config
end

-- probably a better way to init this
runConfig = M.readConfig()

M.setList = function(list)
  runConfig = list
  saveConfig()
end

M.listAt = function(index)
  return runConfig[index]
end


return M
