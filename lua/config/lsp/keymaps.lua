local M = {}

local whichkey = require "which-key"
-- local legendary = require "legendary"

-- local keymap = vim.api.nvim_set_keymap
-- local buf_keymap = vim.api.nvim_buf_set_keymap
local keymap = vim.keymap.set

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Key mappings
  -- buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
  keymap("n", "K", vim.lsp.buf.hover, { buffer = bufnr })

  keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
  keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
  keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)

  -- Whichkey
  local keymap_l = {
    l = {
      name = "LSP",
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
      d = { "<cmd>lua require('telescope.builtin').diagnostics()<CR>", "Diagnostics" },
      F = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      n = { "<cmd>lua require('renamer').rename()<CR>", "Rename" },
      r = { "<cmd>lua require('telescope.builtin').lsp_references()<CR>", "References" },
      s = { "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", "Document Symbols" },
      t = { "<cmd>TroubleToggle document_diagnostics<CR>", "Trouble" },
      L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
      l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
      D = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
      A = { "<cmd>Lspsaga code_action<CR>", "Saga Code Action" },
      h = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
      I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
      b = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
      j = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    },
  }

  local keymap_d = {
    d = {
      name = "Diagnostics",
      x = { "<cmd>TroubleToggle<CR>", "Toggle Trouble" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
      R = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
      j = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev Diagnostic" },
      k = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    },
  }
  if client.server_capabilities.documentFormattingProvider then
    keymap_l.l.f = { "<cmd>lua vim.lsp.buf.format({async = true})<CR>", "Format Document" }
    keymap_l.l.p = { "<cmd>:Prettier<CR>", "Run Prettier" }
    keymap_l.l.e = { "<cmd>:ESlintFixAll<CR>", "Run ESLint Fix" }
  end

  local keymap_v_l = {
    l = {
      name = "LSP",
      a = { "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    },
  }

  local o = { buffer = bufnr, prefix = "<leader>" }
  whichkey.register(keymap_l, o)
  whichkey.register(keymap_d, o)

  o = { mode = "v", buffer = bufnr, prefix = "<leader>" }
  whichkey.register(keymap_v_l, o)
  -- legendary.bind_whichkey(keymap_v_l, o, false)

  o = { buffer = bufnr, prefix = "g" }
  whichkey.register(keymap_g, o)
  -- legendary.bind_whichkey(keymap_g, o, false)
end

-- local function signature_help(client, bufnr)
--   local trigger_chars = client.server_capabilities.signatureHelpProvider.triggerCharacters
--   for _, char in ipairs(trigger_chars) do
--     vim.keymap.set("i", char, function()
--       vim.defer_fn(function()
--         pcall(vim.lsp.buf.signature_help)
--       end, 0)
--       return char
--     end, {
--       buffer = bufnr,
--       noremap = true,
--       silent = true,
--       expr = true,
--     })
--   end
-- end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
  -- signature_help(client, bufnr) -- use cmp-nvim-lsp-signature-help
end

return M
