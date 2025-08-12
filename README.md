<div align="center">
    <h1>A Neovim Config</h1>
    <p>
        <img alt="Gemini_Generated_Image_uxud1auxud1auxud" src="https://github.com/user-attachments/assets/603dc7e4-1afd-43cf-81b1-677932334a74" width=100% />
    </p>
    <p>
        <img alt="Static Badge" src="https://img.shields.io/badge/NEOVIM-%3E%3D0.11-auto?logo=neovim">
        <img alt="Static Badge" src="https://img.shields.io/badge/Linux-auto?logo=linux">
        <img alt="Lua" src="https://img.shields.io/badge/Lua-2C2D72?logo=lua&logoColor=white&style=flat">
        <img alt="Static Badge" src="https://img.shields.io/badge/LSP-auto?logo=lsp">
        <img alt="Static Badge" src="https://img.shields.io/badge/Treesitter-green?logo=Gumtree">
    </p>
    <p>
        <a href="./README.md">[English]</a>
        <a>|</a>
        <a href="./readme/README_cn.md">[简体中文]</a>
    </p>
    <p>
        This repository is a collection of configurations for Neovim and community plugins. 
        The goal is to create a ready-to-use and fully functional Neovim setup by relying mostly on built-in features, 
        and to keep extra dependencies to a minimum except for essential functionality.  
    </p>
</div>

<img width=100% alt="屏幕截图_20250807_030514" src="https://github.com/user-attachments/assets/0cfe11ef-a122-4bc6-a937-a9a941c5a9ef" />

## ✨ Features

- **召之即来的终端**: 无需离开编辑器，即可在当前窗口或分屏中快速访问内置终端，处理编译、测试等任务。
- **强大的 LSP 支持**: 享受现代 IDE 般的开发体验，包括实时错误诊断、精准的代码补全、定义跳转、引用查找等。
- **无缝集成的 Yazi**: 将高效的终端文件管理器 Yazi 融入 Neovim，在熟悉的环境中以极快的速度预览和管理你的项目文件。
- **统一的实例管理**: 任何从内置终端打开的文件都会在当前窗口中加载，确保始终聚焦于单一实例，告别窗口管理的烦恼。
- **万物皆可搜**: 集成 Telescope，让你轻松查找文件、Grep 全局内容、Git 提交记录、LSP 诊断信息等。
- **深度 Git 集成**: 直接在编辑器侧边栏查看文件改动（Gitsigns），浏览历史记录（diffview）等，无需切换到命令行。
- **快速的项目管理**:  为 nvim 添加了项目管理功能，允许你在已保存的项目之间切换以及在最近两个项目之间跳转。

## 📎 Dependencies

⚠️ **注意**: 根据实际情况选择安装
- **必须**
    - [`neovim`](https://neovim.io): `nvim`本身,建议用最新版本(可以用发行版包管理器下载).
    - [`fzf`](https://github.com/junegunn/fzf): 一个用于任何类型列表的互动筛选程序.
    - [`ripgrep`](https://github.com/BurntSushi/ripgrep): ripgrep 是一种面向行的搜索工具.
- **可选**
    - [`yazi`](https://github.com/sxyazi/yazi): 一个用Rust编写的终端文件管理器.
    - [`unzip`](http://infozip.sourceforge.net/UnZip.html): 解压`zip`文件,有些**linux**可能自带.
    - [`ttf-jetbrains-mono-nerd`](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip): 一种支持连体的字体.

## ⚡ Installation

### Linux

<details>
<summary>点击预览 🌞</summary>

1. **可选步骤**: 先将自己的配置备份 

~~~bash
$ cp ~/.config/nvim/ ~/.config/nvim.backup
~~~

2. 执行 `$ nvim $HOME/.${SHELL##*/}rc` 命令，在文件中添加以下内容:

~~~bash
# Define a shell function to open files in a running Neovim instance
nvim_remote() {
  local files=()
  for f in "$@"; do
    # Use absolute path if provided, otherwise prepend current directory
    if [[ "$f" = /* ]]; then
      files+=("$f")
    else
      files+=("$PWD/$f")
    fi
  done
  pid="${NVIM#*.}"
  pid="${pid%%.*}"
  nvim --server $HOME/.cache/nvim/server_$(echo $pid).pipe --remote "${files[@]}"
}

# Check for NVIM environment variable
if [[ -n "$NVIM" ]]; then
  # Alias 'nvim' to the function
  alias nvim='nvim_remote'

  pid="${NVIM#*.}"
  pid="${pid%%.*}"
  export EDITOR="nvim --server $HOME/.cache/nvim/server_$(echo $pid).pipe --remote "$@""
fi
~~~

3. 使用以下命令克隆项目:

~~~bash
$ cd ~/.config/nvim/
$ git clone https://github.com/CookingPlosion/nvim.git
~~~

4. 可以开始使用了，安装插件需要终端代理

~~~bash
$ nvim
~~~
</details>

