-- lualine
return {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    keys = {
       -- { "<A-1>", "<cmd>LualineBuffersJump! 1<cr>" },
       -- { "<A-2>", "<cmd>LualineBuffersJump! 2<cr>" },
       -- { "<A-3>", "<cmd>LualineBuffersJump! 3<cr>" },
       -- { "<A-4>", "<cmd>LualineBuffersJump! 4<cr>" },
       -- { "<A-5>", "<cmd>LualineBuffersJump! 5<cr>" },
       -- { "<A-6>", "<cmd>LualineBuffersJump! 6<cr>" },
       -- { "<A-7>", "<cmd>LualineBuffersJump! 7<cr>" },
       -- { "<A-8>", "<cmd>LualineBuffersJump! 8<cr>" },
       -- { "<A-9>", "<cmd>LualineBuffersJump! 9<cr>" },
       -- { "<A-$>", "<cmd>LualineBuffersJump! $<cr>" },
    },
    config = function ()
        -- Eviline config for lualine
        -- Author: shadmansaleh
        -- Credit: glepnir
        local lualine = require('lualine')

        -- Color table for highlights
        -- stylua: ignore
        local colors = {
            bg       = '#202328',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#51afef',
            red      = '#ec5f67',
        }

        --- @param trunc_width number trunctates component when screen width is less then trunc_width
        --- @param trunc_len number truncates component to trunc_len number of chars
        --- @param hide_width number hides component when window width is smaller then hide_width
        --- @param no_ellipsis boolean whether to disable adding '...' at end after truncation
        --- return function that can format the component accordingly
        local function trunc(trunc_width, trunc_len, hide_width, no_ellipsis)
            return function(str)
                local win_width = vim.fn.winwidth(0)
                if hide_width and win_width < hide_width then
                    return ''
                elseif trunc_width and trunc_len and win_width < trunc_width and #str > trunc_len then
                    return str:sub(1, trunc_len) .. (no_ellipsis and '' or '...')
                end
                return str
            end
        end

        -- Config
        local config = {
            options = {
                -- Disable sections and component separators
                component_separators = '',
                section_separators = '',
                theme = {
                    -- We are going to use lualine_c an lualine_x as left and
                    -- right section. Both are highlighted by c theme .  So we
                    -- are just setting default looks o statusline
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                 },
                disabled_filetypes = {'neo-tree'}
            },
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x at right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            function()
                return '▊'
            end,
            color = { fg = colors.blue }, -- Sets highlighting of component
            padding = { left = 0, right = 1 }, -- We don't need space before this
        }

        ins_left {
            -- mode component
            function()
                return ''
            end,
            color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                n = colors.red,
                i = colors.green,
                v = colors.blue,
                [''] = colors.blue,
                V = colors.blue,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.violet,
                Rv = colors.violet,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { right = 1 },
        }

        ins_left { "filesize", fmt = trunc(0, 0, 60, true), }

        ins_left {
            "filetype",
            icon_only = true,
            fmt = trunc(0, 0, 60, true),
        }

        ins_left {
            function ()
                local trunc_nmuber = 12
                local filename = vim.fn.expand('%:t:r')
                -- local trunc_prefix_filename = string.sub(filename, 1 , trunc_nmuber)
                local ex = '.' .. vim.fn.expand('%:e')
                if #ex == 1 then
                    ex = ""
                end
                if #filename < trunc_nmuber * 2 then
                    return filename .. ex
                end
                local trunc_suffix_filename = string.sub(filename, #filename - trunc_nmuber - 8, #filename)
                return "..." .. trunc_suffix_filename .. ex
            end,
            padding = { left = 0, right = 1 },
            color = { fg = colors.magenta, gui = 'bold' },
            fmt = trunc(0, 0, 20, true)
        }

        ins_left { 'location', fmt = trunc(0, 0, 60, true), }

        ins_left {
            'progress',
            color = { fg = colors.fg, gui = 'bold' },
            fmt = trunc(0, 0, 30, true),
        }

        ins_left {
            'diagnostics',
            fmt = trunc(0, 0, 110, true),
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
            },
            always_visible = true,
        }

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2
        ins_left {
            function()
                return '%='
            end,
            fmt = trunc(0, 145, 100, true),
        }

        ins_left {
        -- Lsp server name .
            function()
                local msg = 'No Active Lsp'
                local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = ' LSP:',
            color = { fg = '#ffffff', gui = 'bold' },
            fmt = trunc(150, 0, 150, true)
        }

        -- window number
        ins_right {
            function ()
                return vim.api.nvim_win_get_number(0)
            end,
            icon = '󰂵 WN:',
            fmt = trunc(0, 0, 120, true)
        }

        -- Shows 'MI:line' in lualine when both tab and spaces are used for indenting current buffer.
        ins_right {
            function()
                local space_pat = [[\v^ +]]
                local tab_pat = [[\v^\t+]]
                local space_indent = vim.fn.search(space_pat, 'nwc')
                local tab_indent = vim.fn.search(tab_pat, 'nwc')
                local mixed = (space_indent > 0 and tab_indent > 0)
                local mixed_same_line
                if not mixed then
                    mixed_same_line = vim.fn.search([[\v^(\t+ | +\t)]], 'nwc')
                    mixed = mixed_same_line > 0
                end
                if not mixed then return '' end
                if mixed_same_line ~= nil and mixed_same_line > 0 then
                    return 'MI:'..mixed_same_line
                end
                local space_indent_cnt = vim.fn.searchcount({pattern=space_pat, max_count=1e3}).total
                local tab_indent_cnt =  vim.fn.searchcount({pattern=tab_pat, max_count=1e3}).total
                if space_indent_cnt > tab_indent_cnt then
                    return 'MI:'..tab_indent
                else
                    return 'MI:'..space_indent
                end
            end,
            fmt = trunc(0, 10, 80, true)
        }

        -- Add components to right sections
        ins_right {
            'o:encoding', -- option component same as &encoding in viml
            fmt = trunc(0, 1, 50, true),
            -- cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'fileformat',
            fmt = trunc(0, 1, 70, true),
            icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
            fmt = trunc(0, 1, 40, true),
        }

        ins_right {
            'diff',
            fmt = trunc(0, 0, 140, true),
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
        }

        ins_right {
            function()
                return '▊'
            end,
            color = { fg = colors.blue },
            padding = { left = 1 },
        }

        -- Now don't forget to initialize lualine
        lualine.setup(config)
    end,
}
