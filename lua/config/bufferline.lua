local M = {}

function M.setup()
  require("bufferline").setup {
    options = {
      numbers = 'none',
      buffer_close_icon = "",
      modified_icon = "●",
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      diagnostics = "nvim_lsp", -- | "nvim_lsp" | "coc",
      diagnostics_update_in_insert = false,
      offsets = {
        {
          filetype = "NvimTree",
          text = "Explorer",
          padding = 1,
          highlight = "Directory",
          text_align = "left"
        },
      },
      show_buffer_icons = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      show_tab_indicators = false,
      separator_style = 'thick',


    }
  }
end

return M
