--#.................................................#--
--#                 _                  _            #--
--#   ___ _____ __ ( )___   _ ____   _(_)_ __ ___   #--
--#  / __|_  / '_ \|// __| | '_ \ \ / / | '_ ` _ \  #--
--# | (__ / /| |_) | \__ \ | | | \ V /| | | | | | | #--
--#  \___/___| .__/  |___/ |_| |_|\_/ |_|_| |_| |_| #--
--#          |_|                                    #--
--#.................................................#--

--#=================
--# basic config
--#=================
require ('base')
require ('highlights')

--#================
--# set kbd 
--#================
require ('keymap')

--#================
--# set kbd 
--#================
require ('autocmd')


--#================
--# lazy 
--#================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
 vim.fn.system({
  "git",
  "clone",
  "--filter=blob:none",
  "--single-branch",
  "https://github.com/folke/lazy.nvim.git",
  lazypath,
 })
end

vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
 defaults = { lazy = true },
 install = { colorscheme = { "onedark" } },
 checker = { enabled = true },
 change_detection = {
  notify = false,
 },
 performance = {
  rtp = {
   disabled_plugins = {
    "gzip",
    "matchit",
    "matchparen",
    "netrwPlugin",
    "tarPlugin",
    "tohtml",
    "tutor",
    "zipPlugin",
   },
  },
 },
})
