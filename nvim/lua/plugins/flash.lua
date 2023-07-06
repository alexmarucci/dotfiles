local present, flash = pcall(require, 'flash')
if not present then
  return
end

flash.setup({
  modes = {
    char = {
      autohide = true,
      highlight = { backdrop = false },
      jump_labels = true,

      keys = { "f", "F", "t", "T" },
    },
  }
})
