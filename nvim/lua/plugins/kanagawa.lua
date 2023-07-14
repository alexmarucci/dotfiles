local present, kanagawa = pcall(require, 'kanagawa')
if not present then
  return
end



kanagawa.setup({
  dimInactive = true,

  colors = {
    palette = {
      lotusGray = "Grey80",
      lotusWhite0 = "Grey55",
      lotusWhite1 = "Grey65",
      lotusWhite2 = "Grey70",
      lotusWhite3 = "Grey90",
      lotusWhite4 = "Grey80",
      lotusWhite5 = "Grey75",
      lotusViolet1 = "#a09cac",
    },

    theme = {
      lotus = {
        ui = {
          bg_p2 = 'Grey95',
          special = 'White',
        }
      }
    }
  }
})
vim.cmd.colorscheme('kanagawa')
