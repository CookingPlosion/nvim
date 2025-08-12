<div align="center">
    <h1>Neovim 配置</h1>
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
        <a href="../README.md">[English]</a>
        <a>|</a>
        <a>[简体中文]</a>
    </p>
    <p>
        这个仓库是 Neovim 及其社区插件的配置集合。
        目标是通过主要依赖内置功能来创建一个即用型且功能完整的 Neovim 设置，
        并将额外依赖项保持在最低限度，除了必要的功能。
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

## ⌨️ Keymaps

### Standard Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<M-p>` | visual | 向上移动行 |
| `<M-n>` | visual | 向下移动行 |
| `j` | normal | 向下移动光标 |
| `k` | normal | 向上移动光标 |
| `<leader>w` | normal | 保存 |
| `<leader>W` | normal | 保存所有 |
| `<leader>q` | normal | 退出 |
| `<leader>Q` | normal | 退出所有 |
| `<leader>n` | normal | 新建文件 |
| `<C-s>` | normal | 强制写入 |
| `<C-q>` | normal | 强制退出 |
| `u` | normal | 静默撤销 |
| `<C-r>` | normal | 静默重做 |
| `|` | normal | 垂直分割 |
| `\` | normal | 水平分割 |

### LSP Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>pm` | normal | Mason 安装器 |
| `<leader>pM` | normal | Mason 更新 |
| `ga` | normal | 打开符号查找器 |
| `ghi` | normal | 查找所有实现 |
| `ghr` | normal | 查找所有引用 |
| `ghd` | normal | 查找所有定义 |
| `gr` | normal | 重命名符号 |
| `gR` | normal | 重命名符号（项目范围） |
| `gd` | normal | 预览定义 |
| `gD` | normal | 跳转到定义 |
| `gt` | normal | 预览类型定义 |
| `gT` | normal | 跳转到类型定义 |
| `<leader>lo` | normal | 显示缓冲区中的符号 |
| `<leader>dl` | normal | 显示行诊断 |
| `<leader>dc` | normal | 显示光标诊断 |
| `<leader>db` | normal | 显示缓冲区诊断 |
| `<leader>dw` | normal | 显示工作区诊断 |
| `<leader>li` | normal | 显示 LSP 信息 |
| `<leader>ll` | normal | 显示 LSP 日志 |
| `<leader>la` | normal | LSP 代码操作 |
| `[d` | normal | 跳转到上一个诊断 |
| `]d` | normal | 跳转到下一个诊断 |
| `K` | normal, visual | 显示符号信息 |
| `[e` | normal | 跳转到上一个错误 |
| `]e` | normal | 跳转到下一个错误 |
| `[w` | normal | 跳转到上一个警告 |
| `]w` | normal | 跳转到下一个警告 |
| `[i` | normal | 跳转到上一个信息 |
| `]i` | normal | 跳转到下一个信息 |

### Buffer/Window Management
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>c` | normal | 关闭缓冲区 |
| `<leader>C` | normal | 强制关闭缓冲区 |
| `<leader>br` | normal | 关闭右侧所有缓冲区 |
| `<leader>bl` | normal | 关闭左侧所有缓冲区 |
| `<leader>bb` | normal | 从缓冲区行选择缓冲区 |
| `<leader>bd` | normal | 从缓冲区行关闭缓冲区 |
| `<leader>bp` | normal | 切换固定 |
| `<leader>bo` | normal | 关闭其他缓冲区 |
| `<leader>bs` | normal | 排序缓冲区 |
| `<tab>` | normal | 上一个缓冲区 |
| `[b` | normal | 下一个缓冲区 |
| `]b` | normal | 上一个缓冲区 |
| `<leader>t` | normal | 切换终端 |
| `<leader>e` | normal | 切换 yazi |

### File Navigation (Telescope)
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>fc` | normal | 命令行 |
| `<leader>f<cr>` | normal | 恢复上一次搜索 |
| `<leader>fw` | normal | 在当前工作目录中查找单词 |
| `<leader>fb` | normal | 在打开的缓冲区中查找缓冲区 |
| `<leader>ff` | normal | 查找文件 |
| `<leader>fh` | normal | 查找帮助 |
| `<leader>fk` | normal | 查找键映射 |
| `<leader>fm` | normal | 查找手册 |
| `<leader>f'` | normal | 查找标记 |
| `<leader>f/` | normal | 在当前缓冲区中查找单词 |
| `<leader>fs` | normal | 查找 treesitter 符号 |
| `<leader>fW` | normal | 在当前工作目录中查找单词（所有文件） |
| `<leader>fe` | normal | 查找 nvim 配置文件 |
| `<leader>E` | normal | 指定搜索目录 |
| `<leader>fP` | normal | 查找插件文件 |
| `<leader>ft` | normal | 查找主题 |

### Git Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `]g` | normal | 下一个 Git 区块 |
| `[g` | normal | 上一个 Git 区块 |
| `<leader>gl` | normal | 查看 Git 责任 |
| `<leader>gL` | normal | 查看完整 Git 责任 |
| `<leader>gp` | normal | 预览 Git 区块 |
| `<leader>gh` | normal | 重置 Git 区块 |
| `<leader>gr` | normal | 重置 Git 缓冲区 |
| `<leader>gs` | normal | 暂存 Git 区块 |
| `<leader>gS` | normal | 暂存 Git 缓冲区 |
| `<leader>gu` | normal | 取消暂存 Git 区块 |
| `<leader>gd` | normal | 查看 Git 差异 |

### Code Formatting/Linting
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>lf` | normal, visual | 格式化缓冲区 |

### Completion Operations (Blink.cmp)
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<C-d>` | insert | 显示/隐藏文档 |
| `<C-e>` | insert | 隐藏补全 |
| `<C-y>` | insert | 选择并接受 |
| `<Tab>` | insert | 选择并接受/片段前进 |
| `<S-Tab>` | insert | 片段后退 |
| `<Up>` | insert | 选择上一个补全 |
| `<Down>` | insert | 选择下一个补全 |
| `<C-p>` | insert | 选择上一个补全 |
| `<C-n>` | insert | 选择下一个补全 |
| `<C-b>` | insert | 向上滚动文档 |
| `<C-f>` | insert | 向下滚动文档 |
| `<C-k>` | insert | 显示/隐藏签名 |

### Comment Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>//` | normal | 切换注释行 |
| `<leader>//` | visual | 切换选择内容的注释 |
| `<leader>/f` | normal | 函数注释文档 |
| `<leader>/c` | normal | 类注释文档 |
| `<leader>/F` | normal | 文件注释文档 |
| `<leader>/t` | normal | 类型注释文档 |

### Project Management
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>sc` | normal | 关闭当前项目 |
| `<leader>sa` | normal | 创建项目 |
| `<leader>sw` | normal | 保存现有项目 |
| `<leader>sf` | normal | 切换项目 |
| `<leader>so` | normal | 切换项目 |

### Command-line Abbreviations
| Abbreviation | Expansion | Description |
| ------------ | --------- | ----------- |
| Q | q | 退出 |
| q1 | q! | 强制退出 |
| Q! | q! | 强制退出 |
| Q1 | q! | 强制退出 |
| Qa | qa | 退出所有 |
| Qa! | qa! | 强制退出所有 |
| Qa1 | qa! | 强制退出所有 |
| Qall | qall | 退出所有 |
| Qall! | qall! | 强制退出所有 |
| W | w | 写入 |
| W! | w! | 强制写入 |
| w1 | w! | 强制写入 |
| W1 | w! | 强制写入 |
| WQ | wq | 写入并退出 |
| WQ1 | wq! | 强制写入并退出 |
| Wa | wa | 写入所有 |
| Wq | wq | 写入并退出 |
| Wq1 | wq! | 强制写入并退出 |
| wQ | wq | 写入并退出 |
| wQ1 | wq! | 强制写入并退出 |
| wq1 | wq! | 强制写入并退出 |
| Y | y | 复制 |
| N | n | 否 |