return {
  -- Telescope + зависимости
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Цветовая схема rose-pine
  
  {"olivercederborg/poimandres.nvim", name="poimandres"},

  -- Harpoon
  { "ThePrimeagen/harpoon" },

  -- Undotree
  { "mbbill/undotree" },

  -- autopairs ()[]{}
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  -- Fugitive
  { "tpope/vim-fugitive" },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {"folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {},
  },

  -- nvim-cmp (completion)
  -- LSP
  { "neovim/nvim-lspconfig" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- LSP source
      "hrsh7th/cmp-buffer",    -- слова из текущего буфера
      "hrsh7th/cmp-path",      -- пути файлов
      "L3MON4D3/LuaSnip",      -- движок сниппетов (можно потом расширить)
      "saadparwaiz1/cmp_luasnip", -- подсказки из сниппетов
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(), -- вызвать меню вручную
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Enter = подтвердить
          ["<Tab>"] = cmp.mapping.select_next_item(), -- Tab = следующее
          ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Shift-Tab = предыдущее
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}

