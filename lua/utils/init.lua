local M = {}

--- 检查插件是否在 lazy 中定义。适用于懒加载，当插件尚未加载时。
---@param plugin string 要搜索的插件
---@return boolean available # 插件是否可用
function M.is_available(plugin)
  local lazy_config_avail, lazy_config = pcall(require, 'lazy.core.config')
  return lazy_config_avail and lazy_config.spec.plugins[plugin] ~= nil
end

--- 获取一个空的映射表，其中每个模式都有一个键
---@return table<string,table> # 一个包含每个映射模式条目的表
function M.empty_map_table()
  local maps = {}
  for _, mode in ipairs { '', 'n', 'v', 'x', 's', 'o', '!', 'i', 'l', 'c', 't' } do
    maps[mode] = {}
  end
  if vim.fn.has 'nvim-0.10.0' == 1 then
    for _, abbr_mode in ipairs { 'ia', 'ca', '!a' } do
      maps[abbr_mode] = {}
    end
  end
  return maps
end

--- 基于表的 API 设置键映射
---@param map_table table 嵌套表，第一个键是 vim 模式，第二个键是要映射的键，值是设置映射的函数
---@param base? table 每个键绑定要设置的一组基本选项
function M.set_mappings(map_table, base)
  -- 迭代每个模式的第一个键
  base = base or {}
  for mode, maps in pairs(map_table) do
    -- 迭代当前模式下设置的每个键绑定
    for keymap, options in pairs(maps) do
      -- 根据需要构建命令的选项
      if options then
        local cmd = options
        local keymap_opts = base
        if type(options) == 'table' then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend('force', keymap_opts, options)
          keymap_opts[1] = nil
        end
        if not cmd or keymap_opts.name then -- 如果是 which-key 映射，则排队
          if not keymap_opts.name then
            keymap_opts.name = keymap_opts.desc
          end
          if not M.which_key_queue then
            M.which_key_queue = {}
          end
          if not M.which_key_queue[mode] then
            M.which_key_queue[mode] = {}
          end
          M.which_key_queue[mode][keymap] = keymap_opts
        else -- 如果不是 which-key 映射，则设置它
          vim.keymap.set(mode, keymap, cmd, keymap_opts)
        end
      end
    end
  end
  if package.loaded['which-key'] then
    M.which_key_register()
  end -- 如果 which-key 已加载，则注册
end

--- 插入一个或多个值到类似列表的表中，并确保不插入非唯一值（这会修改 `dst`）
---@param dst any[]|nil 要插入的列表类型的表
---@param src any[] 要插入的值
---@return any[] # 修改后的列表类型的表
function M.list_insert_unique(dst, src)
  if not dst then
    dst = {}
  end
  -- TODO: 删除对 Neovim v0.9 支持后移除检查
  assert(vim.islist(dst), '提供的表不是类似列表的表')
  local added = {}
  for _, val in ipairs(dst) do
    added[val] = true
  end
  for _, val in ipairs(src) do
    if not added[val] then
      table.insert(dst, val)
      added[val] = true
    end
  end
  return dst
end

--- 将唯一键从源表插入目标表。
--- 如果 `src` 中的键不存在于 `des` 中，则将其添加到 `des` 中。
--- 确保 `des` 中没有重复的键。
---@param des table 目标表。
---@param src table 源表。
---@return table<string, table> 更新后的目标表。
function M.table_insert_unique_keys(des, src)
  if not des then
    des = {}
  end
  if not src then
    src = {}
  end

  for key, value in pairs(src) do
    if not des[key] then
      des[key] = value
    end
  end

  return des
end

--- To close the buffer
---@param bufnr number: Incoming buffer number(default bufnr = 0)
---@param force boolean: Force Close
function M.close(bufnr, force)
  if not bufnr or bufnr == 0 then
    bufnr = vim.api.nvim_get_current_buf()
  end
  local buftype = vim.api.nvim_get_option_value("buftype", { buf = bufnr })
  vim.cmd(("silent! %s %d"):format((force or buftype == "terminal") and "bdelete!" or "confirm bdelete", bufnr))
end

return M
