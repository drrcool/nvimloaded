local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    max_jobs = 4,
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end

    -- Run PackerCompile if there are changes in this file
    -- vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
    local packer_grp = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
    vim.api.nvim_create_autocmd(
      { "BufWritePost" },
      { pattern = "init.lua", command = "source <afile> | PackerCompile", group = packer_grp }
    )
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    -- Performance
    use { "lewis6991/impatient.nvim" }

    -- Load only when require
    use { "nvim-lua/plenary.nvim", module = "plenary" }

    -- Notification
    use {
      "rcarriga/nvim-notify",
      event = "BufReadPre",
      config = function()
        require("config.notify").setup()
      end,
      disable = true,
    }
    use {
      "simrat39/desktop-notify.nvim",
      config = function()
        require("desktop-notify").override_vim_notify()
      end,
      disable = true,
    }
    use {
      "vigoux/notifier.nvim",
      config = function()
        require("notifier").setup {}
      end,
      disable = false,
    }

    -- Colorscheme
    use {
      "catppuccin/nvim",
      as = "catppuccin",
      config = function()
        vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
        require("catppuccin").setup()
      end,
      disable = false,
    }
    use { "krfl/fleetish-vim" }
    use { "ishan9299/modus-theme-vim" }
    use {
      "NTBBloodbath/doom-one.nvim",
      setup = function()
        -- Add color to cursor
        vim.g.doom_one_cursor_coloring = true
        -- Set :terminal colors
        vim.g.doom_one_terminal_colors = true
        -- Enable italic comments
        vim.g.doom_one_italic_comments = true
        -- Enable TS support
        vim.g.doom_one_enable_treesitter = true
        -- Color whole diagnostic text or only underline
        vim.g.doom_one_diagnostics_text_color = true
        -- Enable transparent background
        vim.g.doom_one_transparent_background = false
        -- Pumblend transparency
        vim.g.doom_one_pumblend_enable = true
        vim.g.doom_one_pumblend_transparency = 20

        -- Plugins integration
        vim.g.doom_one_plugin_neorg = true
        vim.g.doom_one_plugin_barbar = false
        vim.g.doom_one_plugin_telescope = false
        vim.g.doom_one_plugin_neogit = true
        vim.g.doom_one_plugin_nvim_tree = true
        vim.g.doom_one_plugin_dashboard = true
        vim.g.doom_one_plugin_startify = true
        vim.g.doom_one_plugin_whichkey = true
        vim.g.doom_one_plugin_indent_blankline = true
        vim.g.doom_one_plugin_vim_illuminate = true
        vim.g.doom_one_plugin_lspsaga = false
      end,
      config = function()
        vim.cmd "colorscheme doom-one"
      end,
    }
    use { "dracula/vim" }
    use { "nxvu699134/vn-night.nvim" }
    use {
      "folke/tokyonight.nvim",
      disable = false,
    }
    use {
      "sainnhe/everforest",
      config = function()
        vim.g.everforest_better_performance = 1
      end,
      disable = true,
    }
    use {
      "projekt0n/github-nvim-theme",
      disable = false,
    }
    use {
      "sainnhe/gruvbox-material",
      config = function() end,
      disable = true,
    }
    use {
      "arcticicestudio/nord-vim",
      config = function() end,
      disable = true,
    }
    use {
      "nvchad/nvim-colorizer.lua",
      cmd = "ColorizerToggle",
      config = function()
        require("colorizer").setup()
      end,
    }
    use {
      "rktjmp/lush.nvim",
      cmd = { "LushRunQuickstart", "LushRunTutorial", "Lushify", "LushImport" },
      disable = false,
    }
    use {
      "max397574/colortils.nvim",
      cmd = "Colortils",
      config = function()
        require("colortils").setup()
      end,
    }
    use {
      "ziontee113/color-picker.nvim",
      cmd = { "PickColor", "PickColorInsert" },
      config = function()
        require "color-picker"
      end,
    }
    use {
      "lifepillar/vim-colortemplate",
      disable = false,
    }
    use {
      "Th3Whit3Wolf/space-nvim",
    }
    use {
      "ray-x/starry.nvim",
    }
    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- Better Netrw
    use { "tpope/vim-vinegar", event = "BufReadPre" }

    use {
      "lewis6991/gitsigns.nvim",
      event = "BufReadPre",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("config.gitsigns").setup()
      end,
    }
    use {
      "tpope/vim-fugitive",
      opt = true,
      cmd = { "Git", "GBrowse", "Gdiffsplit", "Gvdiffsplit" },
      requires = {
        "tpope/vim-rhubarb",
        "idanarye/vim-merginal",
        --[[ "rhysd/committia.vim", ]]
      },
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
      event = "VimEnter",
      module = { "which-key" },
      -- keys = { [[<leader>]] },
      config = function()
        require("config.whichkey").setup()
      end,
      disable = false,
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("config.indentblankline").setup()
      end,
    }

    -- Better icons
    use {
      "nvim-tree/nvim-web-devicons",
      module = "nvim-web-devicons",
      config = function()
        require("nvim-web-devicons").setup { default = true }
      end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("config.comment").setup()
      end,
      disable = false,
    }
    use { "tpope/vim-commentary", keys = { "gc", "gcc", "gbc" }, disable = true }

    -- Better surround
    use { "tpope/vim-surround", event = "BufReadPre" }

    -- Motions
    use { "andymass/vim-matchup", event = "CursorMoved" }
    use { "wellle/targets.vim", event = "CursorMoved", disable = false }
    use {
      "unblevable/quick-scope",
      keys = { "F", "f", "T", "t" },
      -- config = function()
      --   vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
      -- end,
      disable = false,
    }
    use { "chaoren/vim-wordmotion", opt = true, fn = { "<Plug>WordMotion_w" } }

    -- Buffer
    use { "kazhala/close-buffers.nvim", cmd = { "BDelete", "BWipeout" } }
    use {
      "matbme/JABS.nvim",
      cmd = "JABSOpen",
      config = function()
        require("config.jabs").setup()
      end,
      disable = false,
    }
    use {
      "chentoast/marks.nvim",
      event = "BufReadPre",
      config = function()
        require("marks").setup {}
      end,
    }

    -- IDE
    use {
      "max397574/better-escape.nvim",
      event = { "InsertEnter" },
      config = function()
        require("better_escape").setup {
          mapping = { "jk" },
          timeout = vim.o.timeoutlen,
          keys = "<ESC>",
        }
      end,
    }
    use { "google/vim-searchindex", event = "BufReadPre" }
    use { "tyru/open-browser.vim", event = "BufReadPre" }
    use { "mbbill/undotree", cmd = { "UndotreeToggle" } }
    use {
      "echasnovski/mini.nvim",
      event = { "BufReadPre" },
      config = function()
        require("config.mini").setup()
      end,
    }

    -- Jumps
    use {
      "ggandor/leap.nvim",
      keys = { "s", "S" },
      config = function()
        local leap = require "leap"
        leap.add_default_mappings()
      end,
      disable = false,
    }
    use {
      "abecodes/tabout.nvim",
      after = { "nvim-cmp" },
      config = function()
        require("tabout").setup {
          completion = false,
          ignore_beginning = true,
        }
      end,
    }
    use { "AndrewRadev/splitjoin.vim", keys = { "gS", "gJ" }, disable = false }

    -- Markdown
    use {
      "iamcco/markdown-preview.nvim",
      opt = true,
      run = function()
        vim.fn["mkdp#util#install"]()
      end,
      ft = "markdown",
      cmd = { "MarkdownPreview" },
      requires = { "zhaozg/vim-diagram", "aklt/plantuml-syntax" },
    }
    use {
      "jakewvincent/mkdnflow.nvim",
      config = function()
        require("mkdnflow").setup {}
      end,
      ft = "markdown",
    }
    use {
      "nvim-neorg/neorg",
      config = function()
        require("neorg").setup {
          load = {
            ["core.defaults"] = {},
            ["core.presenter"] = {
              config = {
                zen_mode = "truezen",
              },
            },
          },
        }
      end,
      ft = "norg",
      requires = { "nvim-lua/plenary.nvim", "Pocco81/TrueZen.nvim" },
      disable = true,
    }
    -- Status line
    use {
      "nvim-lualine/lualine.nvim",
      event = "BufReadPre",
      config = function()
        require("config.lualine").setup()
      end,
    }
    use {
      "zbirenbaum/copilot-cmp",
      after = { "copilot.lua" },
      config = function()
        require("copilot_cmp").setup()
      end,
    }
    use {
      "zbirenbaum/copilot.lua",
      event = "vimenter",
      config = function()
        vim.defer_fn(function()
          require("copilot").setup {
            panel = {
              auto_refresh = true,
            },
          }
        end, 100)
      end,
    }
    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("config.treesitter").setup()
      end,
      requires = {
        { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufReadPre" },
        { "windwp/nvim-ts-autotag", event = "InsertEnter" },
        { "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPre" },
        { "p00f/nvim-ts-rainbow", event = "BufReadPre" },
        { "RRethy/nvim-treesitter-textsubjects", event = "BufReadPre" },
        { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle" } },
        -- {
        --   "lewis6991/spellsitter.nvim",
        --   config = function()
        --     require("spellsitter").setup()
        --   end,
        -- },
        { "nvim-treesitter/nvim-treesitter-context", event = "BufReadPre", disable = true },
        { "mfussenegger/nvim-treehopper", module = { "tsht" }, disable = true },
        {
          "m-demare/hlargs.nvim",
          config = function()
            require("config.hlargs").setup()
          end,
          disable = false,
        },
        {
          "AckslD/nvim-FeMaco.lua",
          config = function()
            require("femaco").setup()
          end,
          ft = { "markdown" },
          cmd = { "Femaco" },
          module = { "femaco_edit" },
          disable = true,
        },
        -- { "yioneko/nvim-yati", event = "BufReadPre" },
      },
    }

    use {
      "nvim-telescope/telescope.nvim",
      event = { "VimEnter" },
      config = function()
        require("config.telescope").setup()
      end,
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
        { "nvim-telescope/telescope-project.nvim" },
        { "cljoly/telescope-repo.nvim" },
        { "nvim-telescope/telescope-file-browser.nvim" },
        {
          "nvim-telescope/telescope-frecency.nvim",
          requires = "tami5/sqlite.lua",
        },
        {
          "ahmedkhalf/project.nvim",
          config = function()
            require("config.project").setup()
          end,
        },
        { "nvim-telescope/telescope-dap.nvim" },
        {
          "AckslD/nvim-neoclip.lua",
          requires = {
            { "tami5/sqlite.lua", module = "sqlite" },
          },
        },
        { "nvim-telescope/telescope-smart-history.nvim" },
        { "nvim-telescope/telescope-media-files.nvim" },
        { "dhruvmanila/telescope-bookmarks.nvim" },
        { "nvim-telescope/telescope-github.nvim" },
        { "jvgrootveld/telescope-zoxide" },
        { "Zane-/cder.nvim" },
        "nvim-telescope/telescope-symbols.nvim",
        -- "nvim-telescope/telescope-ui-select.nvim",
      },
    }

    -- nvim-tree
    use {
      "nvim-tree/nvim-tree.lua",
      opt = true,
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Buffer line
    use {
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    -- User interface
    use {
      "stevearc/dressing.nvim",
      event = "BufReadPre",
      config = function()
        require("dressing").setup {
          input = { relative = "editor" },
          select = {
            backend = { "telescope", "fzf", "builtin" },
          },
        }
      end,
      disable = false,
    }
    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        { "hrsh7th/cmp-nvim-lsp", module = { "cmp_nvim_lsp" } },
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "lukas-reineke/cmp-rg",
        "davidsierradz/cmp-conventionalcommits",
        { "onsails/lspkind-nvim", module = { "lspkind" } },
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("config.snip").setup()
          end,
          module = { "luasnip" },
        },
        "rafamadriz/friendly-snippets",
        "honza/vim-snippets",
        { "tzachar/cmp-tabnine", run = "./install.sh", disable = true },
      },
    }

    -- Auto pairs
    use {
      "windwp/nvim-autopairs",
      opt = true,
      event = "InsertEnter",
      module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
      config = function()
        require("config.autopairs").setup()
      end,
    }

    -- Auto tag
    use {
      "windwp/nvim-ts-autotag",
      opt = true,
      event = "InsertEnter",
      config = function()
        require("nvim-ts-autotag").setup { enable = true }
      end,
    }

    -- End wise
    use {
      "RRethy/nvim-treesitter-endwise",
      opt = true,
      event = "InsertEnter",
      disable = false,
    }

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("config.lsp").setup()
      end,
      requires = {
        -- { "lvimuser/lsp-inlayhints.nvim", branch = "readme" },
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "folke/neodev.nvim",
        "RRethy/vim-illuminate",
        "jose-elias-alvarez/null-ls.nvim",
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup {}
          end,
        },
        { "b0o/schemastore.nvim", module = { "schemastore" } },
        { "jose-elias-alvarez/typescript.nvim", module = { "typescript" } },
        {
          "SmiteshP/nvim-navic",
          -- "alpha2phi/nvim-navic",
          config = function()
            require("nvim-navic").setup {}
          end,
          module = { "nvim-navic" },
        },
        {
          "simrat39/inlay-hints.nvim",
          config = function()
            require("inlay-hints").setup()
          end,
        },
        {
          "theHamsta/nvim-semantic-tokens",
          config = function()
            require("config.semantictokens").setup()
          end,
          disable = false,
        },
      },
    }

    -- trouble.nvim
    use {
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      module = { "trouble.providers.telescope" },
      config = function()
        require("trouble").setup {
          use_diagnostic_signs = true,
        }
      end,
    }

    -- lspsaga.nvim
    use {
      "glepnir/lspsaga.nvim",
      cmd = { "Lspsaga" },
      config = function()
        require("config.lspsaga").setup()
      end,
    }

    -- renamer.nvim
    use {
      "filipdutescu/renamer.nvim",
      module = { "renamer" },
      config = function()
        require("renamer").setup {}
      end,
    }

    -- Terminal
    use {
      "akinsho/toggleterm.nvim",
      keys = { [[<C-\>]] },
      cmd = { "ToggleTerm", "TermExec" },
      module = { "toggleterm", "toggleterm.terminal" },
      config = function()
        require("config.toggleterm").setup()
      end,
    }

    -- Debugging
    use {
      "mfussenegger/nvim-dap",
      opt = true,
      module = { "dap" },
      requires = {
        { "theHamsta/nvim-dap-virtual-text", module = { "nvim-dap-virtual-text" } },
        { "rcarriga/nvim-dap-ui", module = { "dapui" } },
        { "mfussenegger/nvim-dap-python", module = { "dap-python" } },
        "nvim-telescope/telescope-dap.nvim",
        { "leoluz/nvim-dap-go", module = "dap-go" },
        { "jbyuki/one-small-step-for-vimkind", module = "osv" },
        { "mxsdev/nvim-dap-vscode-js", module = { "dap-vscode-js" } },
        {
          "microsoft/vscode-js-debug",
          opt = true,
          run = "npm install --legacy-peer-deps && npm run compile",
          disable = false,
        },
      },
      config = function()
        require("config.dap").setup()
      end,
      disable = false,
    }

    -- Test
    use {
      "nvim-neotest/neotest",
      requires = {
        {
          "vim-test/vim-test",
          event = { "BufReadPre" },
          config = function()
            require("config.test").setup()
          end,
        },
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        { "nvim-neotest/neotest-vim-test", module = { "neotest-vim-test" } },
        { "nvim-neotest/neotest-python", module = { "neotest-python" } },
        { "nvim-neotest/neotest-plenary", module = { "neotest-plenary" } },
        { "nvim-neotest/neotest-go", module = { "neotest-go" } },
        { "haydenmeade/neotest-jest", module = { "neotest-jest" } },
        { "rouge8/neotest-rust", module = { "neotest-rust" } },
      },
      module = { "neotest", "neotest.async" },
      config = function()
        require("config.neotest").setup()
      end,
      disable = false,
    }
    use { "diepm/vim-rest-console", ft = { "rest" }, disable = false }
    -- AI completion
    use { "github/copilot.vim", event = "InsertEnter", disable = false }

    -- Legendary
    use {
      "mrjones2014/legendary.nvim",
      opt = true,
      keys = { [[<C-p>]] },
      module = { "legendary" },
      cmd = { "Legendary" },
      config = function()
        require("config.legendary").setup()
      end,
    }

    -- Harpoon
    use {
      "ThePrimeagen/harpoon",
      module = {
        "harpoon",
        "harpoon.cmd-ui",
        "harpoon.mark",
        "harpoon.ui",
        "harpoon.term",
        "telescope._extensions.harpoon",
      },
      config = function()
        require("config.harpoon").setup()
      end,
    }

    -- Refactoring
    use {
      "ThePrimeagen/refactoring.nvim",
      module = { "refactoring", "telescope" },
      keys = { [[<leader>r]] },
      config = function()
        require("config.refactoring").setup()
      end,
    }
    use {
      "kevinhwang91/nvim-bqf",
      ft = "qf",
      disable = false,
      config = function()
        require("config.bqf").setup()
      end,
    }
    use { "nvim-pack/nvim-spectre", module = "spectre", keys = { "<leader>s" } }
    use {
      "https://gitlab.com/yorickpeterse/nvim-pqf",
      event = "BufReadPre",
      config = function()
        require("pqf").setup()
      end,
    }
    use {
      "andrewferrier/debugprint.nvim",
      module = { "debugprint" },
      keys = { "g?p", "g?P", "g?v", "g?V", "g?o", "g?O" },
      cmd = { "DeleteDebugPrints" },
      config = function()
        require("debugprint").setup()
      end,
    }

    -- Performance
    use { "dstein64/vim-startuptime", cmd = "StartupTime" }
    use {
      "nathom/filetype.nvim",
      cond = function()
        return vim.fn.has "nvim-0.8.0" == 0
      end,
    }

    -- Web
    use {
      "vuki656/package-info.nvim",
      opt = true,
      requires = {
        "MunifTanjim/nui.nvim",
      },
      module = { "package-info" },
      ft = { "json" },
      config = function()
        require("config.package").setup()
      end,
      disable = false,
    }
    -- Session
    use {
      "rmagatti/auto-session",
      opt = true,
      cmd = { "SaveSession", "RestoreSession" },
      requires = { "rmagatti/session-lens" },
      config = function()
        require("bad_practices").setup()
      end,
      disable = false,
    }
    -- Practice
    -- Plugin
    use {
      "tpope/vim-scriptease",
      cmd = {
        "Messages", --view messages in quickfix list
        "Verbose", -- view verbose output in preview window.
        "Time", -- measure how long it takes to run some stuff.
      },
      event = "BufReadPre",
    }

    -- Todo
    use {
      "folke/todo-comments.nvim",
      config = function()
        require("config.todocomments").setup()
      end,
      cmd = { "TodoQuickfix", "TodoTrouble", "TodoTelescope" },
    }

    -- Diffview
    use {
      "sindrets/diffview.nvim",
      requires = "nvim-lua/plenary.nvim",
      cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
    }

    -- Sidebar
    use {
      "sidebar-nvim/sidebar.nvim",
      cmd = { "SidebarNvimToggle" },
      config = function()
        require("sidebar-nvim").setup {
          open = false,
          side = "right",
          sections = { "datetime", "todos", "buffers", "diagnostics", "git" },
          bindings = {
            ["q"] = function()
              require("sidebar-nvim").close()
            end,
          },
        }
      end,
    }
    use {
      "stevearc/aerial.nvim",
      config = function()
        require("aerial").setup {
          backends = { "treesitter", "lsp" },
          on_attach = function(bufnr)
            vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
            vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
          end,
        }
      end,
      module = { "aerial", "telescope._extensions.aerial" },
      cmd = { "AerialToggle" },
    }

    -- Task runner
    use {
      "stevearc/overseer.nvim",
      opt = true,
      module = { "neotest.consumers.overseer" },
      cmd = {
        "OverseerToggle",
        "OverseerOpen",
        "OverseerRun",
        "OverseerBuild",
        "OverseerClose",
        "OverseerLoadBundle",
        "OverseerSaveBundle",
        "OverseerDeleteBundle",
        "OverseerRunCmd",
        "OverseerQuickAction",
        "OverseerTaskAction",
      },
      config = function()
        require("overseer").setup()
      end,
    }
    use {
      "michaelb/sniprun",
      run = "bash ./install.sh",
      cmd = { "SnipRun", "SnipInfo", "SnipReset", "SnipReplMemoryClean", "SnipClose", "SnipLive" },
      module = { "sniprun", "sniprun.api" },
    }

    use { "muniftanjim/eslint.nvim" }
    use { "muniftanjim/prettier.nvim" }
    -- Database
    use {
      "tpope/vim-dadbod",
      opt = true,
      requires = {
        "kristijanhusak/vim-dadbod-ui",
        "kristijanhusak/vim-dadbod-completion",
        --[[ "abenz1267/nvim-databasehelper", ]]
      },
      config = function()
        require("config.dadbod").setup()
      end,
      cmd = { "DBUIToggle", "DBUI", "DBUIAddConnection", "DBUIFindBuffer", "DBUIRenameBuffer", "DBUILastQueryInfo" },
    }
    use {
      "nanotee/sqls.nvim",
      module = { "sqls" },
      cmd = {
        "SqlsExecuteQuery",
        "SqlsExecuteQueryVertical",
        "SqlsShowDatabases",
        "SqlsShowSchemas",
        "SqlsShowConnections",
        "SqlsSwitchDatabase",
        "SqlsSwitchConnection",
      },
    }
    use {
      "dinhhuy258/vim-database",
      run = ":UpdateRemotePlugins",
      cmd = { "VDToggleDatabase", "VDToggleQuery", "VimDatabaseListTablesFzf" },
    }

    -- Testing
    use {
      "linty-org/readline.nvim",
      event = { "BufReadPre" },
      config = function()
        require("config.readline").setup()
      end,
    }
    use {
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker").setup {
          disable_legacy_commands = true,
        }
      end,
      cmd = { "IconPickerNormal", "IconPickerYank", "IconPickerInsert" },
      disable = false,
    }

    use {
      "m-demare/attempt.nvim",
      opt = true,
      requires = "nvim-lua/plenary.nvim",
      module = { "attempt" },
      config = function()
        require("config.attempt").setup()
      end,
      disable = false,
    }
    use { "mg979/vim-visual-multi", event = "BufReadPre", disable = false }
    use {
      "epwalsh/obsidian.nvim",
      disable = true,
      config = function()
        require("obsidian").setup {
          dir = "~/my-notes",
          completion = {
            nvim_cmp = true, -- if using nvim-cmp, otherwise set to false
          },
        }
      end,
    }
    use {
      "mrjones2014/smart-splits.nvim",
    }
    use {
      "rbong/vim-buffest",
    }
    -- https://github.com/WhoIsSethDaniel/toggle-lsp-diagnostics.nvim
    -- https://github.com/rbong/vim-buffest
    -- https://github.com/jamestthompson3/nvim-remote-containers
    -- https://github.com/esensar/nvim-dev-container
    -- https://github.com/ziontee113/icon-picker.nvim
    -- https://github.com/rktjmp/lush.nvim
    -- https://github.com/charludo/projectmgr.nvim
    -- https://github.com/katawful/kreative
    -- https://github.com/kevinhwang91/nvim-ufo

    -- Bootstrap Neovim
    if packer_bootstrap then
      print "Neovim restart is required after installation!"
      require("packer").sync()
    end
  end

  -- Init and start packer
  packer_init()
  local packer = require "packer"

  -- Performance
  pcall(require, "impatient")
  -- pcall(require, "packer_compiled")

  packer.init(conf)
  packer.startup(plugins)
end

return M
