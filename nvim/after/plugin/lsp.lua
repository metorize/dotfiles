-- ==================== Общие хоткеи при подключении LSP ====================
local on_attach = function(_, bufnr)
  local b = { buffer = bufnr, silent = true }
  local map = function(m, lhs, rhs) vim.keymap.set(m, lhs, rhs, b) end
  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "gi", vim.lsp.buf.implementation)
  map("n", "N",  vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end)
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
end

-- ==================== Диагностика ====================
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

-- ==================== capabilities (nvim-cmp, если стоит) ====================
local capabilities = vim.lsp.protocol.make_client_capabilities()
pcall(function()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
end)

-- ==================== gopls через новый API ====================
local util = require("lspconfig.util")  -- утилиты типа root_pattern можно тянуть отсюда

vim.lsp.configs = vim.lsp.configs or {}

-- Регистрируем gopls (только один раз)
if not vim.lsp.configs.gopls then
  vim.lsp.configs.gopls = {
    default_config = {
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      single_file_support = true,
      settings = {
        gopls = {
          gofumpt = true,
          analyses = { unusedparams = true, shadow = true },
          staticcheck = true,
          completeUnimported = true,
          semanticTokens = true,
          directoryFilters = {
            "-.git", "-node_modules", "-vendor",
            "-bazel-bin", "-bazel-out", "-bazel-testlogs",
            "-out", "-build", "-dist", "-bin",
          },
        },
      },
    },
  }
end

-- Автозапуск gopls при открытии go-файла
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function(args)
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git")(args.file),
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
})

-- ==================== Формат/импорты по сохранению именно gopls ====================
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function(args)
    vim.lsp.buf.format({
      bufnr = args.buf,
      timeout_ms = 2000,
      filter = function(client) return client.name == "gopls" end,
    })
  end,
})

-- ==================== :LspRestart (свой, на всякий случай) ====================
vim.api.nvim_create_user_command("LspRestart", function()
  local clients = vim.lsp.get_clients({ buf = 0 })
  for _, c in ipairs(clients) do
    vim.lsp.stop_client(c.id, true)
  end
  vim.cmd("edit") -- пересчитать буфер, gopls поднимется заново
end, { desc = "Restart LSP for current buffer" })

