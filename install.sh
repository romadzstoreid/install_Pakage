#!/data/data/com.termux/files/usr/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear

echo -e "${CYAN}================================${RESET}"
echo -e "${CYAN}        INSTALLER TERMUX        ${RESET}"
echo -e "${CYAN}================================${RESET}"
echo ""

loading() {
    local text="$1"
    shift

    local frames=("⠋" "⠙" "⠹" "⠸" "⠼" "⠴" "⠦" "⠧" "⠇" "⠏")
    local pid
    local i=0

    # stdin diarahkan ke /dev/null agar kalau ada prompt tak terduga,
    # proses langsung gagal (EOF) daripada hang selamanya menunggu input
    "$@" </dev/null >/dev/null 2>&1 &
    pid=$!

    while kill -0 "$pid" 2>/dev/null; do
        printf "\r${YELLOW}%s${RESET} ${CYAN}%s${RESET}" "$text" "${frames[i]}"
        i=$(( (i + 1) % ${#frames[@]} ))
        sleep 0.1
    done

    wait "$pid"
    local result=$?

    if [ $result -eq 0 ]; then
        printf "\r${YELLOW}%s${RESET} ${GREEN}✓${RESET}\n" "$text"
    else
        printf "\r${YELLOW}%s${RESET} ${RED}✗${RESET}\n" "$text"
        exit 1
    fi
}

# Mode non-interaktif: cegah pkg/apt menampilkan prompt konfirmasi
# (misalnya soal file konfigurasi yang berubah) yang bisa membuat
# proses di background hang tanpa pernah selesai.
export DEBIAN_FRONTEND=noninteractive

loading "[1/5] Updating Packages" bash -c '
    pkg update -y \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold" \
    && pkg upgrade -y \
        -o Dpkg::Options::="--force-confdef" \
        -o Dpkg::Options::="--force-confold"
'

loading "[2/5] Installing Node.js" pkg install nodejs -y

loading "[3/5] Checking Node.js" bash -c 'node -v && npm -v'

loading "[4/5] Initializing NPM" npm init -y

loading "[5/5] Installing Axios" npm install axios

echo ""
echo -e "${CYAN}================================${RESET}"
echo -e "${GREEN}       INSTALLATION DONE        ${RESET}"
echo -e "${CYAN}================================${RESET}"
echo ""
echo -e "Node.js : ${GREEN}$(node -v)${RESET}"
echo -e "NPM     : ${GREEN}$(npm -v)${RESET}"
echo -e "Axios   : ${GREEN}Installed${RESET}"
echo ""
echo -e "${GREEN}✓ Environment Node.js siap digunakan.${RESET}"
echo ""
echo -e "Buat file sesuai kebutuhan:"
echo -e "${YELLOW}nano nama-file.js${RESET}"
echo ""
echo -e "Kemudian jalankan:"
echo -e "${YELLOW}node nama-file.js${RESET}"
