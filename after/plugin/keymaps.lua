-- local keymap = vim.api.nvim_set_keymap
local keymap = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Better escape using jk in insert and terminal mode
keymap("i", "jk", "<ESC>", default_opts)
keymap("t", "jk", "<C-\\><C-n>", default_opts)
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", default_opts)
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", default_opts)
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", default_opts)
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", default_opts)

-- Center search results
keymap("n", "n", "nzz", default_opts)
keymap("n", "N", "Nzz", default_opts)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- -- Always center
keymap("n", "k", "kzz", default_opts)
keymap("n", "j", "jzz", default_opts)
keymap("n", "G", "Gzz", default_opts)

-- Better indent
keymap("v", "<", "<gv", default_opts)
keymap("v", ">", ">gv", default_opts)

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_opts)

-- Switch buffer
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", default_opts)
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", default_opts)

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_opts)

-- Move selected line / block of text in visual mode
keymap("x", "K", ":move '<-2<CR>gv=gv", default_opts)
keymap("x", "J", ":move '>+1<CR>gv=gv", default_opts)

-- Resizing panes
keymap("n", "<Left>", ":vertical resize +1<CR>", default_opts)
keymap("n", "<Right>", ":vertical resize -1<CR>", default_opts)
keymap("n", "<Up>", ":resize -1<CR>", default_opts)
keymap("n", "<Down>", ":resize +1<CR>", default_opts)

keymap("n", "<leader>sh", "<C-w>h", default_opts)
keymap("n", "<leader>sj", "<C-w>j", default_opts)
keymap("n", "<leader>sk", "<C-w>k", default_opts)
keymap("n", "<leader>sr", "<C-w>l", default_opts)
keymap("n", "<leader>ss", ":ssplit<CR>", default_opts)
keymap("n", "<leader>sv", ":vsplit<CR>", default_opts)
keymap("n", "<M-k>", "<Cmd>lua require('smart-splits').resize_up(3)<CR>", default_opts)
keymap("n", "<M-j>", "<Cmd>lua require('smart-splits').resize_down(3)<CR>", default_opts)
keymap("n", "<M-h>", "<Cmd>lua require('smart-splits').resize_left(3)<CR>", default_opts)
keymap("n", "<M-l>", "<Cmd>lua require('smart-splits').resize_right(3)<CR>", default_opts)
-- moving between splits
-- pass same_row as a boolean to override the default
-- for the move_cursor_same_row config option.
-- See Configuration.
keymap("n", "<C-k>", "<cmd>lua require('smart-splits').move_cursor_up()<CR>", default_opts)
keymap("n", "<C-j>", "<cmd>lua require('smart-splits').move_cursor_down()<CR>", default_opts)
keymap("n", "<C-h>", "<cmd>lua require('smart-splits').move_cursor_left()<CR>", default_opts)
keymap("n", "<C-l>", "<cmd>lua require('smart-splits').move_cursor_right()<CR>", default_opts)
-- Insert blank line
keymap("n", "]<Space>", "o<Esc>", default_opts)
keymap("n", "[<Space>", "O<Esc>", default_opts)

-- Browser search
keymap("n", "gx", "<Plug>(openbrowser-smart-search)", default_opts)
keymap("x", "gx", "<Plug>(openbrowser-smart-search)", default_opts)

-- windows.kvim
-- keymap("n", "<C-w>z", "<Cmd>WindowsMaximize<CR>", default_opts)

-- focus.nvim
keymap("n", "<C-w>z", "<Cmd>FocusMaxOrEqual<CR>", default_opts)

keymap("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", default_opts)
keymap("n", "<leader>E", "<Cmd>SidebarNvimToggle<CR>", default_opts)
