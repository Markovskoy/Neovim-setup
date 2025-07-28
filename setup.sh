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

echo "📁 Копируем конфиг Neovim из локальной папки"
mkdir -p ~/.config/nvim/lazy
cp ./nvim-config/init.lua ~/.config/nvim/init.lua
cp -r ./nvim-config/lazy/lazy.nvim ~/.config/nvim/lazy/lazy.nvim

echo "✅ Установка завершена. Запусти nvim и в нём команду :Lazy sync"
