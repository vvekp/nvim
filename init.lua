require("config.lazy")
require("config.lazy")
require("plugins.example")
require("code_runner")
require("template_chooser")
require("lazyvim.plugins")
-- Set Catppuccin as the colorscheme
vim.cmd.colorscheme("noctis")
vim.opt.clipboard:append("unnamedplus")
-- Create a group for the autocmds
local numbertoggle_group = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

-- Enable relative numbering in normal and visual modes
vim.api.nvim_create_autocmd("InsertEnter", {
  group = numbertoggle_group,
  pattern = "*",
  command = "set norelativenumber",
})

vim.api.nvim_create_autocmd("InsertLeave", {
  group = numbertoggle_group,
  pattern = "*",
  command = "set relativenumber",
})

-- Always show the absolute line number
vim.o.number = true

local lspconfig = require("lspconfig")
require("lspconfig/configs")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup({
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
})
-- Include lspconfig
-- local lspconfig = require("lspconfig")

-- Configure Prisma LSP
lspconfig.prismals.setup({
  cmd = { "prisma-language-server", "--stdio" },
  filetypes = { "prisma" },
  settings = {
    prisma = {
      prismaFmtBinPath = "", -- Path to prisma-fmt binary (optional)
    },
  },
})

require("lspconfig").rust_analyzer.setup({
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
      },
    },
  },
})
