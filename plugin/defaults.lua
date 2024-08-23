local wrap = function (func, index)
  return function ()
    func(index)
  end
end


vim.keymap.set("n", '<leader>re', require("Runrun").runEditor)
vim.keymap.set("n", '<leader>rr', wrap(require("Runrun").runCommand, 1))
vim.keymap.set("n", '<leader>rd', wrap(require("Runrun").runCommand, 2))

--terminal
vim.keymap.set("n", '<leader>rt', wrap(require("Runrun").runTerminal, 1))
