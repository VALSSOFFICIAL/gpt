#!/bin/bash
# ==========================================
# FNZ_DEV Bot Uninstaller
# by FNZ_DEV
# ==========================================

GREEN='\e[92m'
RESET='\e[0m'

clear
echo -e "${GREEN}======================================${RESET}"
echo -e "${GREEN}    🚀 FNZ_DEV Bot Uninstaller 🚀     ${RESET}"
echo -e "${GREEN}======================================${RESET}"

# Tanya konfirmasi
read -p $'\e[92m⚠️ Yakin ingin menghapus FNZ_DEV Bot? (y/n): \e[0m' confirm

if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo -e "${GREEN}❌ Batal uninstall.${RESET}"
  exit 1
fi

# Hentikan bot jika berjalan via PM2
if command -v pm2 &> /dev/null; then
  echo -e "${GREEN}🛑 Menghentikan bot dengan PM2...${RESET}"
  pm2 delete gpt >/dev/null 2>&1
  pm2 save
fi

# Cari folder project
PROJECT_DIR="$HOME/gpt"

if [ -d "$PROJECT_DIR" ]; then
  echo -e "${GREEN}🗑️ Menghapus folder project...${RESET}"
  rm -rf "$PROJECT_DIR"
else
  echo -e "${GREEN}⚠️ Folder project tidak ditemukan di $PROJECT_DIR${RESET}"
fi

# Hapus Node.js & npm (opsional)
read -p $'\e[92m❓ Hapus Node.js & npm juga? (y/n): \e[0m' delnode
if [[ "$delnode" == "y" || "$delnode" == "Y" ]]; then
  echo -e "${GREEN}🗑️ Menghapus Node.js & npm...${RESET}"
  sudo apt remove -y nodejs npm
  sudo apt autoremove -y
fi

echo -e "${GREEN}✅ FNZ_DEV Bot berhasil di-uninstall!${RESET}"
