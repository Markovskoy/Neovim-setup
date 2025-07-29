#!/bin/bash

set -e

echo "🔧 Установка Neovim 0.11 в ~/.local/bin"
mkdir -p ~/.local/bin
cd ~/.local/bin
curl -LO https://github.com/neovim/neovim/releases/download/v0.11.3/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract > /dev/null
ln -sf ~/.local/bin/squashfs-root/AppRun ~/.local/bin/nvim
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

echo ""
echo "🔍 Проверка наличия C-компилятора..."
if ! command -v gcc &> /dev/null; then
  echo "🚫 gcc не найден. Устанавливаем build-essential..."
  sudo apt update
  sudo apt install -y build-essential
else
  echo "✅ gcc уже установлен."
fi

echo "📦 Установка LazyGit..."
cd /tmp
curl -LO https://github.com/jesseduffield/lazygit/releases/download/v0.53.0/lazygit_0.53.0_Linux_x86_64.tar.gz
tar -xf lazygit_0.53.0_Linux_x86_64.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -f lazygit*
echo "✅ LazyGit установлен. Версия:"
lazygit --version


echo "📁 Копируем конфиг Neovim из локальной папки"
mkdir -p ~/.config/nvim/lazy
cp "$HOME/Neovim-setup/nvim-config/init.lua" ~/.config/nvim/init.lua
cp -r "$HOME/Neovim-setup/nvim-config/lazy/lazy.nvim" ~/.config/nvim/lazy/lazy.nvim

echo ""
echo "✅ Установка завершена!"

echo ""
echo "   Перезагрузи текущую сессию выполнив в текущем терминале:"
echo "   source ~/.bashrc"
echo ""
echo "   Запусти nvim, обнови плагины 'U'."