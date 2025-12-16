return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable semantic token support
      capabilities.textDocument.semanticTokens = {
        dynamicRegistration = false,
        tokenTypes = {
          "namespace", "type", "class", "enum", "interface", "struct",
          "typeParameter", "parameter", "variable", "property", "enumMember",
          "event", "function", "method", "macro", "keyword", "modifier",
          "comment", "string", "number", "regexp", "operator"
        },
        tokenModifiers = {
          "declaration", "definition", "readonly", "static", "deprecated",
          "abstract", "async", "modification", "documentation", "defaultLibrary"
        },
        formats = { "relative" },
        requests = { range = true, full = { delta = true } },
        multilineTokenSupport = false,
        overlappingTokenSupport = false
      }

      require("lspconfig").clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--pch-storage=memory",
          "--all-scopes-completion",
          "--pretty",
          "--header-insertion=never",
          "-j=4",
          "--inlay-hints",
          "--header-insertion-decorators",
          "--function-arg-placeholders",
          "--completion-style=detailed",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig").util.root_pattern("src"),
        init_option = { fallbackFlags = { "-std=c++2a" } },
        capabilities = capabilities,
        single_file_support = true,
      })
    end,
  },
}
