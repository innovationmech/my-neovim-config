-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- 使用 Mason-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "pyright" },  -- 添加 pyright
})

-- 配置 gopls
require("mason-lspconfig").setup_handlers {
  ["gopls"] = function()
    lspconfig.gopls.setup {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
      cmd = {"gopls"},
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = util.root_pattern("go.work", "go.mod", ".git"),
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
    }
  end,
}

-- 配置 clangd
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup_handlers {
  ["clangd"] = function()
    require("lspconfig").clangd.setup {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--suggest-missing-includes",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--compile-commands-dir=build",
        "--query-driver=/usr/bin/clang++",
      },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = require("lspconfig.util").root_pattern(
        "compile_commands.json",
        "compile_flags.txt",
        ".git"
      ),
      init_options = {
        compilationDatabasePath = "build",
      },
    }
  end,
}

-- 配置 pyright
require("mason-lspconfig").setup_handlers {
  ["pyright"] = function()
    lspconfig.pyright.setup {
      on_attach = require("nvchad.configs.lspconfig").on_attach,
      capabilities = require("nvchad.configs.lspconfig").capabilities,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true
          }
        }
      }
    }
  end,
}

-- 配置 jdtls
require("mason-lspconfig").setup_handlers {
  ["jdtls"] = function()
    -- jdtls 将通过单独的配置文件进行设置
  end,
}

