return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "jose-elias-alvarez/typescript.nvim",
    init = function()
      require("lazyvim.util").lsp.on_attach(function(_, buffer)
        -- stylua: ignore
        vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
        vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        -- lsp shortcuts
        local keys = require("lazyvim.plugins.lsp.keymaps").get()
        keys[#keys + 1] = { "gd", vim.lsp.buf.definition }
      end)
    end,
  },
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options

    servers = {
      -- tsserver will be automatically installed with mason and loaded with lspconfig
      tsserver = {},
      gopls = {},
      tailwindcss = {},
      html = {},
    },
    -- you can do any additional lsp server setup here
    -- return true if you don't want this server to be setup with lspconfig
    ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
    setup = {
      -- example to setup with typescript.nvim
      tsserver = function(_, opts)
        require("typescript").setup({ server = opts })
        return true
      end,
      -- Specify * to use this function as a fallback for any server
      -- ["*"] = function(server, opts) end,
      ["rust_analyzer"] = function() end,
      ["lua_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
            },
          },
        })
      end,
      ["ts_ls"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.ts_ls.setup({
          root_dir = lspconfig.util.root_pattern("package.json"),
          single_file_support = false,
        })
      end,
      ["tailwindcss"] = function()
        local lspconfig = require("lspconfig")
        lspconfig.tailwindcss.setup({
          cmd = { "tailwindcss-language-server", "--stdio" },
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
          },
          root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json"),
          settings = {},
        })
      end,
    },
  },
}
