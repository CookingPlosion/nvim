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
        <a>[English]</a>
        <a>|</a>
        <a href="./doc/README_cn.md">[简体中文]</a>
    </p>
    <p>
        This repository is a collection of configurations for Neovim and community plugins. 
        The goal is to create a ready-to-use and fully functional Neovim setup by relying mostly on built-in features, 
        and to keep extra dependencies to a minimum except for essential functionality.  
    </p>
</div>

<img width=100% alt="Screenshot_20250807_030514" src="https://github.com/user-attachments/assets/0cfe11ef-a122-4bc6-a937-a9a941c5a9ef" />

## ✨ Features

- **Instant Terminal**: Access the built-in terminal quickly in the current window or split screen without leaving the editor to handle compilation, testing, and other tasks.
- **Powerful LSP Support**: Enjoy a modern IDE-like development experience with real-time error diagnostics, precise code completion, definition jumping, and reference finding.
- **Seamless Yazi Integration**: Integrate the efficient terminal file manager Yazi into Neovim to preview and manage your project files at lightning speed in a familiar environment.
- **Unified Instance Management**: Any files opened from the built-in terminal will load in the current window, ensuring focus on a single instance and eliminating window management hassles.
- **Everything Searchable**: Integrated with Telescope, allowing you to easily find files, grep global content, Git commits, LSP diagnostics, and more.
- **Deep Git Integration**: View file changes (Gitsigns) directly in the editor sidebar and browse history (diffview) without switching to the command line.
- **Fast Project Management**: Added project management functionality to nvim, allowing you to switch between saved projects and toggle between the last two projects.

## 📎 Dependencies

⚠️ **Note**: Install based on actual requirements
- **Required**
    - [`neovim`](https://neovim.io): `nvim` itself, recommended to use the latest version (can be downloaded with package manager).
    - [`fzf`](https://github.com/junegunn/fzf): An interactive filter for any type of list.
    - [`ripgrep`](https://github.com/BurntSushi/ripgrep): A line-oriented search tool.
- **Optional**
    - [`yazi`](https://github.com/sxyazi/yazi): A terminal file manager written in Rust.
    - [`unzip`](http://infozip.sourceforge.net/UnZip.html): Unzip `zip` files, some **linux** distributions may already have it.
    - [`ttf-jetbrains-mono-nerd`](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip): A font with ligature support.

## ⚡ Installation

### Linux

<details>
<summary>Click to preview 🌞</summary>

1. **Optional step**: Backup your own configuration first

~~~bash
$ cp ~/.config/nvim/ ~/.config/nvim.backup
~~~

2. Execute `$ nvim $HOME/.${SHELL##*/}rc` command, and add the following content to the file:

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

3. Clone the project with the following command:

~~~bash
$ cd ~/.config/nvim/
$ git clone https://github.com/CookingPlosion/nvim.git
~~~

4. You can start using it now, terminal proxy is required to install plugins

~~~bash
$ nvim
~~~
</details>

## ⌨️ Keymaps

### Standard Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<M-p>` | visual | Move up row |
| `<M-n>` | visual | Move down row |
| `j` | normal | Move cursor down |
| `k` | normal | Move cursor up |
| `<leader>w` | normal | Save |
| `<leader>W` | normal | Save all |
| `<leader>q` | normal | Quit |
| `<leader>Q` | normal | Quit all |
| `<leader>n` | normal | New File |
| `<C-s>` | normal | Force write |
| `<C-q>` | normal | Force quit |
| `u` | normal | Silent undo |
| `<C-r>` | normal | Silent redo |
| `|` | normal | Vertical Split |
| `\` | normal | Horizontal Split |

### LSP Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>pm` | normal | Mason Installer |
| `<leader>pM` | normal | Mason Update |
| `ga` | normal | Open symbol finder |
| `ghi` | normal | Find all implementations |
| `ghr` | normal | Find all references |
| `ghd` | normal | Find all definitions |
| `gr` | normal | Rename symbol |
| `gR` | normal | Rename symbol (project) |
| `gd` | normal | Peek definition |
| `gD` | normal | Goto definition |
| `gt` | normal | Peek type definition |
| `gT` | normal | Goto type definition |
| `<leader>lo` | normal | Show symbols in buffer |
| `<leader>dl` | normal | Show line diagnostics |
| `<leader>dc` | normal | Show cursor diagnostics |
| `<leader>db` | normal | Show buffer diagnostics |
| `<leader>dw` | normal | Show workspace diagnostics |
| `<leader>li` | normal | Show lsp info |
| `<leader>ll` | normal | Show lsp log |
| `<leader>la` | normal | LSP code action |
| `[d` | normal | Jump to previous diagnostic |
| `]d` | normal | Jump to next diagnostic |
| `K` | normal, visual | Show symbol information |
| `[e` | normal | Jump to previous error |
| `]e` | normal | Jump to next error |
| `[w` | normal | Jump to previous warning |
| `]w` | normal | Jump to next warning |
| `[i` | normal | Jump to previous info |
| `]i` | normal | Jump to next info |

### Buffer/Window Management
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>c` | normal | Close buffer |
| `<leader>C` | normal | Force close buffer |
| `<leader>br` | normal | Close all buffers to the right |
| `<leader>bl` | normal | Close all buffers to the left |
| `<leader>bb` | normal | Select buffer from bufferline |
| `<leader>bd` | normal | Close buffer from bufferline |
| `<leader>bp` | normal | Toggle pinned |
| `<leader>bo` | normal | Close other buffers |
| `<leader>bs` | normal | Sort buffers |
| `<tab>` | normal | Previous buffer |
| `[b` | normal | Next buffer |
| `]b` | normal | Previous buffer |
| `<leader>t` | normal | Toggle term |
| `<leader>e` | normal | Toggle yazi |

### File Navigation (Telescope)
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>fc` | normal | cmdline |
| `<leader>f<cr>` | normal | Resume previous search |
| `<leader>fw` | normal | Find words in current working |
| `<leader>fb` | normal | Find buffer in open buffers |
| `<leader>ff` | normal | Find file |
| `<leader>fh` | normal | Find Help |
| `<leader>fk` | normal | Find keymaps |
| `<leader>fm` | normal | Find man |
| `<leader>f'` | normal | Find marks |
| `<leader>f/` | normal | Find words in current buffer |
| `<leader>fs` | normal | Find treesitter symbols |
| `<leader>fW` | normal | Find words in current working(all files) |
| `<leader>fe` | normal | Find nvim config files |
| `<leader>E` | normal | Specifying search directories |
| `<leader>fP` | normal | Find Plugin File |
| `<leader>ft` | normal | Find themes |

### Git Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `]g` | normal | Next Git hunk |
| `[g` | normal | Previous Git hunk |
| `<leader>gl` | normal | View Git blame |
| `<leader>gL` | normal | View full Git blame |
| `<leader>gp` | normal | Preview Git hunk |
| `<leader>gh` | normal | Reset Git hunk |
| `<leader>gr` | normal | Reset Git buffer |
| `<leader>gs` | normal | Stage Git hunk |
| `<leader>gS` | normal | Stage Git buffer |
| `<leader>gu` | normal | Unstage Git hunk |
| `<leader>gd` | normal | View Git diff |

### Code Formatting/Linting
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>lf` | normal, visual | Format buffer |

### Completion Operations (Blink.cmp)
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<C-d>` | insert | Show/hide documentation |
| `<C-e>` | insert | Hide completion |
| `<C-y>` | insert | Select and accept |
| `<Tab>` | insert | Select and accept/snippet forward |
| `<S-Tab>` | insert | Snippet backward |
| `<Up>` | insert | Select previous completion |
| `<Down>` | insert | Select next completion |
| `<C-p>` | insert | Select previous completion |
| `<C-n>` | insert | Select next completion |
| `<C-b>` | insert | Scroll documentation up |
| `<C-f>` | insert | Scroll documentation down |
| `<C-k>` | insert | Show/hide signature |

### Comment Operations
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>//` | normal | Toggle comment line |
| `<leader>//` | visual | Toggle comment for selection |
| `<leader>/f` | normal | Function annotation documentation |
| `<leader>/c` | normal | Class annotation documentation |
| `<leader>/F` | normal | File annotation documentation |
| `<leader>/t` | normal | Type annotation documentation |

### Project Management
| Key | Mode | Description |
| --- | ---- | ----------- |
| `<leader>sc` | normal | Close current project |
| `<leader>sa` | normal | Create a project |
| `<leader>sw` | normal | Save existing project |
| `<leader>sf` | normal | Switch a project |
| `<leader>so` | normal | Toggle project |

### Command-line Abbreviations
| Abbreviation | Expansion | Description |
| ------------ | --------- | ----------- |
| Q | q | Quit |
| q1 | q! | Force quit |
| Q! | q! | Force quit |
| Q1 | q! | Force quit |
| Qa | qa | Quit all |
| Qa! | qa! | Force quit all |
| Qa1 | qa! | Force quit all |
| Qall | qall | Quit all |
| Qall! | qall! | Force quit all |
| W | w | Write |
| W! | w! | Force write |
| w1 | w! | Force write |
| W1 | w! | Force write |
| WQ | wq | Write and quit |
| WQ1 | wq! | Force write and quit |
| Wa | wa | Write all |
| Wq | wq | Write and quit |
| Wq1 | wq! | Force write and quit |
| wQ | wq | Write and quit |
| wQ1 | wq! | Force write and quit |
| wq1 | wq! | Force write and quit |
| Y | y | Yank |
| N | n | No |