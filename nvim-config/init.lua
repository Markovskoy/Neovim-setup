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
  { "nvim-tree/nvim-tree.lua", dependencies = { "nvim-tree/nvim-web-devicons" } },

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
        dashboard.button("e", "  New File", ":ene <BAR> startinsert<CR>"),
        dashboard.button("SPC ee", "  Toggle file explorer", ":NvimTreeToggle<CR>"),
        dashboard.button("SPC gg", "  LazyGit", ":LazyGit<CR>"),
        dashboard.button("SPC kk", " HotKeyHelp",":AlphaKeymap<CR>"),
        dashboard.button("q", "  Quit NVIM", ":qa<CR>"),
      }
    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
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

-- Файловый менеджер
require("nvim-tree").setup()

-- Поиск
require("telescope").setup()

-- Подсветка синтаксиса
require("nvim-treesitter.configs").setup {
  ensure_installed = { "bash", "yaml", "json", "dockerfile", "lua" },
  highlight = { enable = true },
}

-- Горячие клавиши
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Поиск файлов" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Поиск по содержимому" })
keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Файловый менеджер" })
keymap("n", "<leader>kk", "<cmd>AlphaKeymap<CR>", { desc = "Горячие клавиши" })
function OpenLazyGit()
  -- откроет терминал в новой вкладке и закроет после выхода
  vim.cmd("tabnew")
  vim.fn.termopen("lazygit", {
    on_exit = function()
      vim.cmd("bd!")  -- закроет буфер без лишнего вывода
    end,
  })
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>gg", OpenLazyGit, { desc = "LazyGit" })


-- Команда :AlphaKeymap
vim.api.nvim_create_user_command("AlphaKeymap", function()
  vim.notify([[
󰣇  Горячие клавиши:
SPC ff  – Поиск файла
SPC ee  – Файловый менеджер (NvimTree)
CTRL w h– Перейти в левое окно
CTRL w h– Перейти в правое окно
SPC gg  – LazyGit
SPC /   – Поиск в буфере
SPC q   – Закрыть Neovim
  ]], vim.log.levels.INFO, { title = "Keybindings" })
end, {})

