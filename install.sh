#!/data/data/com.termux/files/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

TOTAL_STEPS=6
STEP=0

print_banner() {
  clear
  echo -e "${CYAN}${BOLD}"
  echo "   ██████╗ ██████╗ ████████╗ ██╗   ██╗██████╗ "
  echo "  ██╔════╝██╔═══██╗╚══██╔══╝ ██║   ██║██╔══██╗"
  echo "  ╚█████╗ ╚██████╔╝   ██║    ██║   ██║██████╔╝"
  echo "   ╚═══██╗ ╚═══██╗    ██║    ██║   ██║██╔═══╝ "
  echo "  ██████╔╝ ██████╔╝   ██║    ╚██████╔╝██║     "
  echo "  ╚═════╝  ╚═════╝    ╚═╝     ╚═════╝ ╚═╝     "
  echo -e "${NC}"
  echo -e "${BOLD}          TERMUX AUTO INSTALLER${NC}"
  echo -e "${YELLOW}================================================${NC}"
  echo ""
}

step() {
  STEP=$((STEP + 1))
  echo ""
  echo -e "${CYAN}${BOLD}[${STEP}/${TOTAL_STEPS}]${NC} ${BOLD}$1${NC}"
  echo -e "${YELLOW}------------------------------------------------${NC}"
}

ok() {
  echo -e "${GREEN}✔ $1${NC}"
}

fail() {
  echo -e "${RED}✘ $1${NC}"
  exit 1
}

print_banner

step "Memperbarui daftar paket"
pkg update -y && pkg upgrade -y || fail "Gagal update paket"
ok "Paket berhasil diperbarui"

step "Menginstall Node.js"
pkg install nodejs -y || fail "Gagal menginstall Node.js"
ok "Node.js berhasil diinstall"

step "Memeriksa versi Node.js & NPM"
NODE_VERSION=$(node -v)
NPM_VERSION=$(npm -v)
echo -e "   Node.js : ${GREEN}${NODE_VERSION}${NC}"
echo -e "   NPM     : ${GREEN}${NPM_VERSION}${NC}"
ok "Pemeriksaan versi selesai"

step "Menginisialisasi proyek npm"
npm init -y > /dev/null 2>&1 || fail "Gagal menginisialisasi npm"
ok "package.json berhasil dibuat"

step "Menginstall dependencies (axios)"
npm install axios || fail "Gagal menginstall dependencies"
ok "Dependencies berhasil diinstall"

step "Finalisasi instalasi"
sleep 1
ok "Semua proses instalasi selesai"

echo ""
echo -e "${YELLOW}================================================${NC}"
echo -e "${GREEN}${BOLD}         INSTALASI SELESAI DENGAN SUKSES${NC}"
echo -e "${YELLOW}================================================${NC}"
echo ""
echo -e "${BOLD}Ringkasan:${NC}"
echo -e "   Node.js : ${GREEN}${NODE_VERSION}${NC}"
echo -e "   NPM     : ${GREEN}${NPM_VERSION}${NC}"
echo ""
echo -e "${BOLD}Langkah selanjutnya:${NC}"
echo -e "   ${CYAN}1.${NC} Buat/edit file script:"
echo -e "      ${YELLOW}nano ssweb.js${NC}"
echo ""
echo -e "   ${CYAN}2.${NC} Jalankan script:"
echo -e "      ${YELLOW}node ssweb.js${NC}"
echo ""
echo -e "${YELLOW}================================================${NC}"
