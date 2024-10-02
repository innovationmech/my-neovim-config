local function on_attach(client, bufnr)
  require("nvchad.configs.lspconfig").on_attach(client, bufnr)
  -- 添加Java特定的键位映射
  local map = vim.keymap.set
  map("n", "<leader>jo", "<cmd>lua require'jdtls'.organize_imports()<CR>", { buffer = bufnr, desc = "Organize Imports" })
  map("n", "<leader>jt", "<cmd>lua require'jdtls'.test_class()<CR>", { buffer = bufnr, desc = "Test Class" })
  map("n", "<leader>jn", "<cmd>lua require'jdtls'.test_nearest_method()<CR>", { buffer = bufnr, desc = "Test Nearest Method" })
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_" .. (vim.fn.has("mac") == 1 and "mac" or "linux"),
    "-data", vim.fn.expand("~/.cache/jdtls-workspace") .. vim.fn.getcwd(),
  },
  root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew", "pom.xml", "build.gradle"}),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        useBlocks = true,
      },
    },
  },
  on_attach = on_attach,
  capabilities = require("nvchad.configs.lspconfig").capabilities,
}

config.on_init = function(client, _)
  client.notify('workspace/didChangeConfiguration', { settings = config.settings })
  print("jdtls started")
end

local jdtls_augroup = vim.api.nvim_create_augroup("jdtls_cmds", {clear = true})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    print("Attaching jdtls...")
    require("jdtls").start_or_attach(config)
    print("jdtls attached")
  end,
  group = jdtls_augroup,
})

return config