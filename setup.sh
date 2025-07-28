#!/bin/bash

set -e

echo "🔧 Установка Neovim 0.11 в ~/.local/bin"
mkdir -p ~/.local/bin
cd ~/.local/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract > /dev/null
ln -sf ~/.local/bin/squashfs-root/AppRun ~/.local/bin/nvim
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo "📦 Установка Node.js и npm (только если нет)"
if ! command -v npm >/dev/null; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
  sudo apt install -y nodejs
fi

echo "📁 Установка ~/.config/nvim"
mkdir -p ~/.config/nvim
curl -sSL https://raw.githubusercontent.com/viktor-nvim/devops-config/main/init.lua -o ~/.config/nvim/init.lua

echo "🔌 Установка менеджера плагинов Lazy.nvim"
git clone https://github.com/folke/lazy.nvim ~/.config/nvim/lazy/lazy.nvim

echo "✅ Готово. Запусти nvim и в нём команду :Lazy sync"
