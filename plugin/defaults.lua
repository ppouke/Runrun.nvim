local wrap = function(func, index)
  return function()
    func(index)
  end
end


vim.keymap.set("n", '<leader>re', require("Runrun").runEditor)
vim.keymap.set("n", '<leader>rr', wrap(require("Runrun").runCommand, 1))
vim.keymap.set("n", '<leader>rq', wrap(require("Runrun").runCommand, 2))
vim.keymap.set("n", '<leader>rw', wrap(require("Runrun").runCommand, 3))

--terminal
vim.keymap.set("n", '<leader>rt', wrap(require("Runrun").runTerminal, 1))
