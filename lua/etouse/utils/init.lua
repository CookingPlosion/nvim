-- 自定义函数,变量
local M = {}
-- ---------------------------------- function ---------------------------------- --
-- cmdline echo
function Me_Echo_multiline(msg)
    for _, s in ipairs(vim.fn.split(msg, "\n")) do
        vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
    end
end

function Me_Info(msg)
    vim.cmd("echohl Directory")
    Me_Echo_multiline(msg)
    vim.cmd("echohl None")
end

function Me_Warn(msg)
    vim.cmd("echohl WarningMsg")
    Me_Echo_multiline(msg)
    vim.cmd("echohl None")
end

function Me_Err(msg)
    vim.cmd("echohl ErrorMsg")
    Me_Echo_multiline(msg)
    vim.cmd("echohl None")
end

-- ---------------------------------- 变量 ---------------------------------- --
-- 判断是否为大文件
M.IsNotLargeFile = function()
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
        vim.wo.foldexpr = "0"
        return false
    else
        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
        return true
    end
end

--- Check if a plugin is defined in lazy. Useful with lazy loading when a plugin is not necessarily loaded yet
---@param plugin string The plugin to search for
---@return boolean available # Whether the plugin is available
function M.is_available(plugin)
    local lazy_config_avail, lazy_config = pcall(require, "lazy.core.config")
    return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- Get an empty table of mappings with a key for each map mode
---@return table<string,table> # a table with entries for each map mode
function M.empty_map_table()
    local maps = {}
    for _, mode in ipairs { "", "n", "v", "x", "s", "o", "!", "i", "l", "c", "t" } do
        maps[mode] = {}
    end
    if vim.fn.has "nvim-0.10.0" == 1 then
        for _, abbr_mode in ipairs { "ia", "ca", "!a" } do
            maps[abbr_mode] = {}
        end
    end
    return maps
end

--- Table based API for setting keybindings
---@param map_table table A nested table where the first key is the vim mode, the second key is the key to map, and the value is the function to set the mapping to
---@param base? table A base set of options to set on every keybinding
function M.set_mappings(map_table, base)
    -- iterate over the first keys for each mode
    base = base or {}
    for mode, maps in pairs(map_table) do
        -- iterate over each keybinding set in the current mode
        for keymap, options in pairs(maps) do
            -- build the options for the command accordingly
            if options then
                local cmd = options
                local keymap_opts = base
                if type(options) == "table" then
                    cmd = options[1]
                    keymap_opts = vim.tbl_deep_extend("force", keymap_opts, options)
                    keymap_opts[1] = nil
                end
                if not cmd or keymap_opts.name then -- if which-key mapping, queue it
                    if not keymap_opts.name then keymap_opts.name = keymap_opts.desc end
                    if not M.which_key_queue then M.which_key_queue = {} end
                    if not M.which_key_queue[mode] then M.which_key_queue[mode] = {} end
                    M.which_key_queue[mode][keymap] = keymap_opts
                else -- if not which-key mapping, set it
                    vim.keymap.set(mode, keymap, cmd, keymap_opts)
                end
            end
        end
    end
    if package.loaded["which-key"] then M.which_key_register() end -- if which-key is loaded already, register
end

-- sudo 提权
M.Sudo_exec = function(cmd, print_output)
    vim.fn.inputsave()
    local password = vim.fn.inputsecret("Password: ")
    vim.fn.inputrestore()
    if not password or #password == 0 then
        Me_Warn("Invalid password, sudo aborted")
        return false
    end
    local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
    if vim.v.shell_error ~= 0 then
        print("\r\n")
        Me_Err(out)
        return false
    end
    if print_output then print("\r\n", out) end
    return true
end

-- sudo 写入
M.Sudo_write = function(tmpfile, filepath)
    if not tmpfile then tmpfile = vim.fn.tempname() end
    if not filepath then filepath = vim.fn.expand("%") end
    if not filepath or #filepath == 0 then
        Me_Err("E32: No file name")
        return
    end
    -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
    -- Both `bs=1M` and `bs=1m` are non-POSIX
    local cmd = string.format("dd if=%s of=%s bs=1048576",
        vim.fn.shellescape(tmpfile),
        vim.fn.shellescape(filepath))
    -- no need to check error as this fails the entire function
    vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
    if M.Sudo_exec(cmd) then
        Me_Info(string.format([[\r\n"%s" written]], filepath))
        vim.cmd("e!")
    end
    vim.fn.delete(tmpfile)
end

return M
