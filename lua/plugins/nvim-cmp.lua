return {
    "hrsh7th/nvim-cmp",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-calc",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "onsails/lspkind.nvim"
    },
    opts = function()
        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
        end

        -- local lspkind = require('lspkind')
        local cmp = require("cmp")
        local luasnip = require('luasnip')


        cmp.setup({
            snippet = {
                -- REQUIRED - you must specify a snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = require("lspkind").cmp_format({
                    mode = "symbol",
                    before = function(entry, vim_item)
                        vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
                        if string.upper(entry.source.name) == "COPILOT" then
                            vim_item.kind = " C"
                        end

                        local fixed_width = false

                        local content = vim_item.abbr

                        -- Set the fixed completion window width.
                        if fixed_width then
                            vim.o.pumwidth = fixed_width
                        end

                        -- Get the width of the current window.
                        local win_width = vim.api.nvim_win_get_width(0)

                        -- Set the max content width based on either: 'fixed_width'
                        -- or a percentage of the window width, in this case 20%.
                        -- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
                        local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

                        -- Truncate the completion entry text if it's longer than the
                        -- max content width. We subtract 3 from the max content width
                        -- to account for the "..." that will be appended to it.
                        if #content > max_content_width then
                            vim_item.abbr = vim.fn.strcharpart(" " .. content, 0, max_content_width - 3) .. "..."
                        else
                            vim_item.abbr = " " .. content .. (" "):rep(max_content_width - #content)
                        end
                        return vim_item
                    end
                })
            },
            view = {
                entries = { name = "custom", selection_order = "near_cursor" },
            },
            window = {
                documentation = cmp.config.window.bordered(),
                completion = cmp.config.window.bordered(),
            },
            completion = {
                -- https://zhuanlan.zhihu.com/p/106070272
                completeopt = 'menu,preview',
            },
            experimental = {
                ghost_text = true, -- this feature conflict with copilot.vim's preview.
            },
            sources = cmp.config.sources({
                { name = "luasnip", option = { show_autosnippets = true } },
                { name = "nvim_lsp" },
                { name = "treesitter" },
                { name = "path" },
                { name = "buffer" },
                { name = "calc"},
            }),
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                    elseif require("luasnip").jumpable() then
                        require("luasnip").jump(-1)
                    elseif has_words_before() then
                    else
                        cmp.complete()
                    end
                end, { "i", "s" }),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                    elseif require("luasnip").jumpable() then
                        require("luasnip").jump(1)
                    end
                end, { "i", "s" }),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<TAB>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
            { name = 'buffer' }
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
            { name = 'path' },
            { name = 'cmdline' }
            })
        })
    end,
}
