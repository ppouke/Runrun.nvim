local Path = require("plenary.path")
local configPath = vim.fn.stdpath("data")
local userConfig = string.format("%s/runrun.json", configPath)

local M = {}
local runConfig = {}
local init = false

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
-- function M.setup(config)
--   if not config then
--     config = {}
--   end
--
--   local ok, u_config = pcall(readConfig, userConfig)
--   if not ok then
--     print("No user config present at", userConfig)
--     u_config = {}
--   end
-- end
--
M.setList = function(list)
  runConfig = list
  saveConfig()
end

M.listAt = function (index)
  if not init then
    runConfig = M.readConfig()
    init = true
  end
    return runConfig[index]
end


return M
