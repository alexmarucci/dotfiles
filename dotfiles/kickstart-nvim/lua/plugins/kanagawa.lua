local present, kanagawa = pcall(require, 'kanagawa')
if not present then
  return
end

kanagawa.setup({
  dimInactive = true,


  overrides = function(colors)
    return {
      RenderMarkdownH1Bg = { bg = colors.palette.sumiInk0 , fg = colors.palette.lightBlue },
      RenderMarkdownH2Bg = { bg = colors.palette.sumiInk0, fg = colors.palette.springBlue },
      RenderMarkdownH3Bg = { bg = colors.palette.sumiInk1, fg = colors.palette.waveAqua2  },
      RenderMarkdownH4Bg = { bg = colors.palette.sumiInk1, fg = colors.palette.waveAqua1 },
      RenderMarkdownH5Bg = { bg = colors.palette.sumiInk2 , fg = colors.palette.dragonBlue },
      RenderMarkdownH6Bg = { bg = colors.palette.sumiInk2 , fg = colors.palette.katanaGray },

      RenderMarkdownH1 = { fg = colors.palette.crystalBlue },
      RenderMarkdownH2 = { fg = colors.palette.autumnYellow },
      RenderMarkdownH3 = { fg = colors.palette.crystalBlue },
      RenderMarkdownH4 = { fg = colors.palette.autumnGreen },
      RenderMarkdownH5 = { fg = colors.palette.crystalBlue },
      RenderMarkdownH6 = { fg = colors.palette.dragonBlue },

      RenderMarkdownCode = { bg = colors.palette.sumiInk2 }
    }
  end,

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
