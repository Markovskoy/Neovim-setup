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


echo "📦 Установка LazyGit..."
cd /tmp
curl -L -o lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/download/v0.53.0/lazygit_0.53.0_Linux_x86_64.tar.gz
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -f lazygit.tar.gz lazygit
echo "✅ LazyGit установлен. Версия:"
lazygit --version


echo "📁 Копируем конфиг Neovim из локальной папки"
mkdir -p ~/.config/nvim/lazy
cp ./nvim-config/init.lua ~/.config/nvim/init.lua
cp -r ./nvim-config/lazy/lazy.nvim ~/.config/nvim/lazy/lazy.nvim

echo "✅ Установка завершена. Запусти nvim"
