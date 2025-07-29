-- init.lua

vim.g.mapleader = " "
local keymap = vim.keymap.set

-- Установка Lazy.nvim
vim.opt.rtp:prepend("~/.config/nvim/lazy/lazy.nvim")

require("lazy").setup({
  -- Цветовая тема
  "folke/tokyonight.nvim",

  -- Подсветка синтаксиса
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Git-интеграция
  "lewis6991/gitsigns.nvim",

  -- Файловый менеджер
  "nvim-tree/nvim-tree.lua",

  -- Статусбар
  "nvim-lualine/lualine.nvim",

  -- Поиск
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",

  -- LazyGit Launcher
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Экран приветствия

{
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
    }

      dashboard.section.buttons.val = {
        dashboard.button("e",      "📄  New File",         ":ene <BAR> startinsert<CR>"),
        dashboard.button("SPC ee", "📁  File Explorer",    ":NvimTreeToggle<CR>"),
        dashboard.button("SPC gg", "🔧  LazyGit",          ":LazyGit<CR>"),
        dashboard.button("SPC kk", "💡  HotKeyHelp",       ":AlphaKeymap<CR>"),
        dashboard.button("q",      "❌  Quit NVIM",        ":qa<CR>"),
      }

    -- 📐 Вычисляем точное центрирование
    local function dynamic_padding()
      local header_lines = #dashboard.section.header.val
      local button_lines = #dashboard.section.buttons.val
      local total_lines = header_lines + button_lines + 3  -- +паддинги между ними
      local win_height = vim.fn.winheight(0)
      local pad_top = math.floor((win_height - total_lines) / 2)
      return { type = "padding", val = pad_top }
    end

    dashboard.config.layout = {
      dynamic_padding(),
      dashboard.section.header,
      { type = "padding", val = 2 },
      dashboard.section.buttons,
      { type = "padding", val = 1 },
    }

    alpha.setup(dashboard.config)
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
},
})

  -- Общие настройки
vim.o.number = true
vim.o.relativenumber = false
vim.o.termguicolors = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Цветовая тема
vim.cmd("colorscheme tokyonight")

-- Статусбар
require("lualine").setup()

-- Git-интеграция
require("gitsigns").setup()

require("nvim-tree").setup({
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = "-", -- обычный файл
        symlink = "->",
        folder = {
          arrow_closed = "+",
          arrow_open = "-",
          default = "+",
          open = "-",
          empty = "~",
          empty_open = "~",
          symlink = "->",
          symlink_open = "->",
        },
      },
    },
  },
})



-- Поиск
require("telescope").setup()

-- Подсветка синтаксиса
require("nvim-treesitter.configs").setup {
  ensure_installed = { "bash", "yaml", "json", "dockerfile", "lua" },
  highlight = { enable = true },
}

-- Горячие клавиши
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Поиск файлов" })
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Файловый менеджер" })
keymap("n", "<leader>kk", "<cmd>AlphaKeymap<CR>", { desc = "Горячие клавиши" })

function OpenLazyGit()
  vim.cmd("tabnew")
  vim.fn.termopen("lazygit", {
    on_exit = function()
      vim.cmd("bd!")
    end,
  })
  vim.cmd("startinsert")
end
keymap("n", "<leader>gg", OpenLazyGit, { desc = "LazyGit" })

-- Команда :AlphaKeymap
vim.api.nvim_create_user_command("AlphaKeymap", function()
  vim.notify([[  
💡  Горячие клавиши:
  SPC ff   – Поиск файла
  SPC ee   – Файловый менеджер (NvimTree)
  | Ctrl-w h – Перейти влево
  | Ctrl-w l – Перейти вправо
  SPC gg   – LazyGit
  SPC q    – Закрыть Neovim
]], vim.log.levels.INFO, { title = "⌨️ Keybindings" })
end, {})

