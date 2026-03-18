#!/bin/bash

# Script de Seleção de Tema Calamares
# Este script permite escolher entre o tema Default ou Moderno

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  Calamares Theme Selector                      ${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""

# Verifica se é root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Execute como root: sudo $0${NC}"
    exit 1
fi

# Diretórios
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
THEMES_DIR="$SCRIPT_DIR/themes"
TARGET_DIR="/usr/share/calamares/branding"

echo "Temas disponíveis:"
echo ""
echo "1) Default (Tema clássico do Calamares)"
echo "2) Modern  (Tema moderno com slideshow)"
echo ""
echo -n "Escolha o tema (1 ou 2): "
read -r CHOICE

case $CHOICE in
    1)
        THEME_NAME="default"
        echo -e "${GREEN}Tema Default selecionado!${NC}"
        ;;
    2)
        THEME_NAME="modern"
        echo -e "${GREEN}Tema Modern selecionado!${NC}"
        ;;
    *)
        echo -e "${RED}Opção inválida!${NC}"
        exit 1
        ;;
esac

# Instala o tema
echo ""
echo -e "${YELLOW}Instalando tema...${NC}"

# Cria diretório de destino
mkdir -p "$TARGET_DIR"

# Copia tema
rm -rf "$TARGET_DIR/default" 2>/dev/null || true
cp -r "$THEMES_DIR/$THEME_NAME" "$TARGET_DIR/default"

# Se for o tema moderno, copia slideshow
if [ "$THEME_NAME" = "modern" ]; then
    mkdir -p "$TARGET_DIR/default/slideshow"
    cp -r "$THEMES_DIR/modern/slideshow/"* "$TARGET_DIR/default/slideshow/"
fi

echo -e "${GREEN}Tema instalado com sucesso!${NC}"
echo ""
echo "O tema foi instalado em: $TARGET_DIR/default"
echo ""
echo "Para aplicar automaticamente, você precisa:"
echo "1. Ter o Calamares instalado"
echo "2. Ter um arquivo /etc/calamares/settings.conf"
echo ""
echo "Execute 'calamares' para testar!"

exit 0
