#!/data/data/com.termux/files/usr/bin/bash

YELLOW='\033[1;33m'
GREEN='\033[1;32m'
RED='\033[1;31m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear

echo -e "${CYAN}================================${RESET}"
echo -e "${CYAN}        TERMUX INSTALLER        ${RESET}"
echo -e "${CYAN}================================${RESET}"
echo ""

echo -ne "${YELLOW}[1/5] Update Package${RESET} "
if pkg update -y >/dev/null 2>&1; then
    echo -e "${GREEN}✓${RESET}"
else
    echo -e "${RED}✗${RESET}"
    exit 1
fi

echo -ne "${YELLOW}[2/5] Upgrade Package${RESET} "
if pkg upgrade -y >/dev/null 2>&1; then
    echo -e "${GREEN}✓${RESET}"
else
    echo -e "${RED}✗${RESET}"
    exit 1
fi

echo -ne "${YELLOW}[3/5] Install Basic Tools${RESET} "
if pkg install -y nodejs python git curl wget nano >/dev/null 2>&1; then
    echo -e "${GREEN}✓${RESET}"
else
    echo -e "${RED}✗${RESET}"
    exit 1
fi

echo -ne "${YELLOW}[4/5] Check Environment${RESET} "
if command -v node >/dev/null 2>&1 && \
   command -v npm >/dev/null 2>&1 && \
   command -v python >/dev/null 2>&1 && \
   command -v git >/dev/null 2>&1; then
    echo -e "${GREEN}✓${RESET}"
else
    echo -e "${RED}✗${RESET}"
    exit 1
fi

echo -ne "${YELLOW}[5/5] Finalizing Installation${RESET} "
sleep 1
echo -e "${GREEN}✓${RESET}"

echo ""
echo -e "${CYAN}================================${RESET}"
echo -e "${GREEN}      INSTALLATION COMPLETE     ${RESET}"
echo -e "${CYAN}================================${RESET}"
echo ""
echo -e "Node.js : ${GREEN}$(node -v)${RESET}"
echo -e "NPM     : ${GREEN}$(npm -v)${RESET}"
echo -e "Python  : ${GREEN}$(python --version 2>&1)${RESET}"
echo -e "Git     : ${GREEN}$(git --version)${RESET}"
echo ""
echo -e "${GREEN}✓ Termux siap digunakan.${RESET}"
