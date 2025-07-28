-- Установка пути к Lazy.nvim
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
  "nvim-telescope/telescope.nvim",
  "nvim-lua/plenary.nvim",

  -- 🆕 Neogit — Git GUI
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neogit").setup()
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

-- Тема
vim.cmd("colorscheme tokyonight")

-- Статусбар
require("lualine").setup()

-- Git
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
vim.g.mapleader = " "
local keymap = vim.keymap.set

-- Поиск через Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Поиск файлов" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Поиск по содержимому" })

-- Git через Neogit
keymap("n", "<leader>gg", "<cmd>Neogit<CR>", { desc = "Git GUI (neogit)" })

