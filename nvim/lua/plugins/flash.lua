local present, flash = pcall(require, 'flash')
if not present then
  return
end

flash.setup({
  modes = {
    char = {
      config = function(opts)
        local isOperator = vim.fn.mode(true):find 'no' and (vim.v.operator == 'y' or vim.v.operator == 'd' or vim.v.operator == 'c');
        -- autohide flash when in operator-pending mode
        opts.autohide = isOperator;

        -- disable jump labels when enabled and when using a count
        -- opts.jump_labels = not isOperator and opts.jump_labels and vim.v.count == 0
        opts.jump_labels = vim.v.count == 0 and not isOperator;

        -- Show jump labels only in operator-pending mode
        -- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
      end,

      highlight = { backdrop = false },

      keys = { "f", "F", "t", "T" },
    },
    remote_op = {
      restore = true,
      motion = true,
    },
  }
})
