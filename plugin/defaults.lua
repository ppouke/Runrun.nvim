local wrap = function (func, index)
  return function ()
    func(index)
  end
end


vim.keymap.set("n", '<leader>rr', wrap(require("Runrun").runCommand, 0))
vim.keymap.set("n", '<leader>rd', wrap(require("Runrun").runCommand, 1))
vim.keymap.set("n", '<leader>rt', wrap(require("Runrun").runCommand, 2))
