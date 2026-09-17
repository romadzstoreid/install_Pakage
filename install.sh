#!/data/data/com.termux/files/usr/bin/bash

GREEN='\033[0;32m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

TOTAL=5
STEP=0

bar() {
  STEP=$((STEP + 1))
  FILLED=$((STEP * 20 / TOTAL))
  EMPTY=$((20 - FILLED))
  PCT=$((STEP * 100 / TOTAL))
  printf "\r${CYAN}["
  printf "%0.s#" $(seq 1 $FILLED)
  printf "%0.s." $(seq 1 $EMPTY)
  printf "] %d%%${NC}  %s\n" "$PCT" "$1"
}

echo -e "${BOLD}Termux Installer${NC}"
echo ""

bar "Update paket"
pkg update -y && pkg upgrade -y

bar "Install Node.js"
pkg install nodejs -y

bar "Cek versi Node & NPM"
node -v && npm -v

bar "Inisialisasi npm"
npm init -y > /dev/null 2>&1

bar "Install axios"
npm install axios

echo ""
echo -e "${GREEN}${BOLD}Instalasi selesai.${NC}"
echo ""
echo "Langkah selanjutnya:"
echo "  nano files"
echo "  node files"
