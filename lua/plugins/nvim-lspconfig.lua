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
            "clangd",
            "lua_ls",
            "pyright",
            "cmake",
            "marksman",
        }

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

        require("mason-lspconfig").setup({
            ensure_installed = servers,
            automatic_installation = true,
        })

        -- Customizing how diagnostics are displayed
        vim.diagnostic.config({
            virtual_text = false,
            signs = true,
            underline = true,
            update_in_insert = false,
            severity_sort = false,
            float = {
                show_header = false,
                close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
                border = 'rounded',
                source = 'always',
                prefix = '',
                scope = 'line',
            }
        })

        -- vim.api.nvim_create_autocmd("CursorHold", {
        --     callback = function()
        --         vim.diagnostic.open_float()
        --     end
        -- })

        -- Change diagnostic symbols in the sign column (gutter)
        local signs = { Error = "", Warn = " ", Hint = "", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions
        vim.keymap.set( 'n', '<space>e', vim.diagnostic.open_float)
        vim.keymap.set( 'n', '[d', vim.diagnostic.goto_next)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

        require("neodev").setup()

        -- for _, lsp in ipairs(servers) do
        --     lspconfig[lsp].setup {
        --         capabilities = capabilities,
        --         -- on_attach = on_attach,
        --     }
        -- end

        -- ----------------language servers run setup---------------- --
        lspconfig.pyright.setup({
            capabilities = capabilities
        })

        lspconfig.clangd.setup({
            capabilities = capabilities
        })

        lspconfig.lua_ls.setup ({
            capabilities = capabilities,
            settings = {
                cmd = { "lua-language-server", "--locale=zh-cn" },
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
            },
        })
    end,
}
