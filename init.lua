--#.................................................#--
--#                 _                  _            #--
--#   ___ _____ __ ( )___   _ ____   _(_)_ __ ___   #--
--#  / __|_  / '_ \|// __| | '_ \ \ / / | '_ ` _ \  #--
--# | (__ / /| |_) | \__ \ | | | \ V /| | | | | | | #--
--#  \___/___| .__/  |___/ |_| |_|\_/ |_|_| |_| |_| #--
--#          |_|                                    #--
--#.................................................#--

for _, source in ipairs {
  "etouse.options",
  "etouse.lazy",
  "etouse.autocmds",
  "etouse.keymaps",
} do
  local status_ok, fault = pcall(require, source)
  if not status_ok then
    vim.api.nvim_err_writeln("加载失败: " .. source .. "\n\n" .. fault)
  end
end
