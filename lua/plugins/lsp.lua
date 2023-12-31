return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  },
  cmd = {
    "Mason",
    "MasonInstall",
    "MasonUninstall",
    "MasonUpdate",
    "MasonUninstallAll",
    "MasonLog"
  },
  config = function()
    -- Add additional capabilities supported by nvim-cmp
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")
    local servers = {
      ["clangd"] = {},
      ["lua_ls"] = {
        cmd = { "lua-language-server", "--locale=zh-cn" },
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
              autoRequire = false,
            },
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
              disable = {
                "redefined-local",
              },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              -- https://github.com/neovim/nvim-lspconfig/issues/1700#issuecomment-1356282825
              checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false,
            },
          },
        }
      },
      -- ["pyright"] = {},
      ["cmake"] = {},
      ["marksman"] = {},
      ["bashls"] = {},
    }

    require("mason-lspconfig").setup({
      ensure_installed = servers,
      automatic_installation = true,
    })

    require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      },
    })

    require("neodev").setup()

    -- Customizing how diagnostics are displayed
    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = false,
      float = {
        show_header = true,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = '',
        scope = 'line',
      }
    })

    -- Change diagnostic symbols in the sign column (gutter)
    local signs = { Error = "", Warn = " ", Hint = "", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Global mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    -- vim.keymap.set('n', '<leader>e', vim.diagnostic.setloclist)
    vim.keymap.set('n', '<leader>i', vim.diagnostic.open_float)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_next)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', '<leader>ld', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, opts)
        vim.keymap.set('n', '<leader>lwa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<leader>lwr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<leader>lwl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>lf', function()
          vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
      end,
    })

    for key, v in pairs(servers) do
      lspconfig[key].setup({
        capabilities = capabilities,
        cmd = v.cmd,
        settings = v.settings,
      })
    end
  end,
}
