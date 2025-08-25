#!/bin/bash

# ================================
# FNZ_DEV BOT INSTALLER
# ================================

# Warna
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m' # No Color

clear
echo -e "${CYAN}"
echo "╔════════════════════════════════════════╗"
echo "║        🚀 FNZ_DEV Telegram Bot         ║"
echo "╚════════════════════════════════════════╝"
echo -e "${NC}"

# Update & upgrade system
echo -e "${YELLOW}⚡ Updating system...${NC}"
sudo apt update -y && sudo apt upgrade -y

# Install dependencies
echo -e "${YELLOW}⚡ Installing dependencies...${NC}"
sudo apt install -y nodejs npm git curl

# Install pm2
echo -e "${YELLOW}⚡ Installing PM2 (Process Manager)...${NC}"
sudo npm install -g pm2

# Clone repo
if [ ! -d "fnzdev-bot" ]; then
  echo -e "${YELLOW}⚡ Cloning FNZ_DEV Bot repository...${NC}"
  git clone https://github.com/VALSSOFFICIAL/gpt.git
fi

cd gpt || exit

# Install node_modules
echo -e "${YELLOW}⚡ Installing Node.js packages...${NC}"
npm install

# Minta input user
echo -e "${CYAN}"
read -p "👉 Masukkan TELEGRAM_BOT_TOKEN: " TELEGRAM_BOT_TOKEN
read -p "👉 Masukkan OPENAI_API_KEY: " OPENAI_API_KEY
echo -e "${NC}"

# Buat file .env
echo -e "${YELLOW}⚡ Menyimpan konfigurasi ke .env...${NC}"
cat > .env <<EOL
TELEGRAM_BOT_TOKEN=$TELEGRAM_BOT_TOKEN
OPENAI_API_KEY=$OPENAI_API_KEY
EOL

# Jalankan dengan pm2
echo -e "${YELLOW}⚡ Menjalankan bot dengan PM2...${NC}"
pm2 start bot.js --name gpt
pm2 save

# Pesan akhir
echo -e "${GREEN}"
echo "========================================="
echo "✅ Installasi selesai!"
echo "🚀 FNZ_DEV Bot sudah aktif!"
echo "-----------------------------------------"
echo "👉 Cek status bot : pm2 status"
echo "👉 Stop bot       : pm2 stop fnzdev-bot"
echo "👉 Restart bot    : pm2 restart fnzdev-bot"
echo "👉 Logs bot       : pm2 logs fnzdev-bot"
echo "========================================="
echo -e "${NC}"
