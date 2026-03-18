#!/bin/bash

# Calamares Universal Installer Script
# Este script ajuda a configurar o Calamares para sua distribuição

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}============================================${NC}"
echo -e "${BLUE}  Calamares Universal - Setup Script       ${NC}"
echo -e "${BLUE}============================================${NC}"
echo ""

# Verifica se é root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Por favor, execute como root (sudo)${NC}"
    exit 1
fi

# Detecta a distribuição
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo $ID
    elif [ -f /etc/lsb-release ]; then
        . /etc/lsb-release
        echo $DISTRIB_ID | tr '[:upper:]' '[:lower:]'
    else
        echo "unknown"
    fi
}

DISTRO=$(detect_distro)
echo -e "${GREEN}Distribuição detectada: ${YELLOW}$DISTRO${NC}"
echo ""

# Diretório de instalação
CALAMARES_DIR="/opt/calamares"
LIB_DIR="/usr/local/lib"
BIN_DIR="/usr/local/bin"

# Instala dependências baseado na distro
install_deps() {
    echo -e "${YELLOW}Instalando dependências para $DISTRO...${NC}"
    
    case "$DISTRO" in
        ubuntu|debian|linuxmint|pop)
            apt update
            apt install -y \
                qt6-base-dev qt6-tools-dev libqt6svg6-dev libqt6xmlpatterns6-dev \
                libkf6coreaddons-dev libkf6i18n-dev libkf6widgetsaddons-dev \
                libkf6config-dev libkf6service-dev libkf6dbusaddons-dev \
                libkf6solid-dev libkf6package-dev libkf6crash-dev \
                libkf6iconthemes-dev libkf6kio-dev libkf6parts-dev \
                libkpmcore-dev libparted-dev libyaml-cpp-dev \
                libcrypt-dev libpwquality-dev libboost-python-dev \
                python3-dev gettext extra-cmake-modules \
                libpolkit-qt6-1-dev libatasmart-dev libappstreamqt-dev
            ;;
        fedora|rhel|centos)
            dnf install -y \
                qt6-qtbase-devel qt6-qttools-devel qt6-qtsvg-devel \
                kf6-kcoreaddons-devel kf6-ki18n-devel kf6-kwidgetsaddons-devel \
                kf6-kconfig-devel kf6-kservice-devel kf6-kdbusaddons-devel \
                kf6-solid-devel kf6-kpackage-devel kf6-kcrash-devel \
                kf6-kiconthemes-devel kf6-kio-devel kf6-kparts-devel \
                kpmcore-devel libparted-devel yaml-cpp-devel \
                libcrypt-devel libpwquality-devel python3-devel \
                boost-python-devel gettext extra-cmake-modules \
                polkit-qt6-devel libatasmart-devel appstream-qt-devel
            ;;
        arch|manjaro|endeavouros)
            pacman -Sy --noconfirm \
                qt6-base qt6-tools qt6-svg qt6-xmlpatterns \
                kf6-kcoreaddons kf6-ki18n kf6-kwidgetsaddons \
                kf6-kconfig kf6-kservice kf6-kdbusaddons \
                kf6-solid kf6-kpackage kf6-kcrash \
                kf6-kiconthemes kf6-kio kf6-kparts \
                kpmcore parted libyaml-cpp libpwquality \
                python boost gettext extra-cmake-modules \
                polkit-qt6 libatasmart appstream
            ;;
        opensuse|opensuse-leap|opensuse-tumbleweed)
            zypper install -y \
                libqt6-qtbase-devel libqt6-qttools-devel libqt6-qtsvg-devel \
                libKF6CoreAddons-devel libKF6I18n-devel libKF6WidgetsAddons-devel \
                libKF6Config-devel libKF6Service-devel libKF6DBusAddons-devel \
                libKF6Solid-devel libKF6Package-devel libKF6Crash-devel \
                libKF6IconThemes-devel libKF6KIO-devel libKF6Parts-devel \
                libkpmcore-devel libparted-devel libyaml-cpp-devel \
                python3-devel gettext-tools extra-cmake-modules \
                polkit-qt6-devel libatasmart-devel
            ;;
        gentoo)
            emerge --ask \
                dev-qt/qtbase dev-qt/qttools dev-qt/qtsvg dev-qt/qtxmlpatterns \
                kde-frameworks/kcoreaddons kde-frameworks/ki18n kde-frameworks/kwidgetsaddons \
                kde-frameworks/kconfig kde-frameworks/kservice kde-frameworks/kdbusaddons \
                kde-frameworks/solid kde-frameworks/kpackage kde-frameworks/kcrash \
                kde-frameworks/kiconthemes kde-frameworks/kio kde-frameworks/kparts \
                kde-apps/kpmcore sys-block/parted dev-cpp/yaml-cpp \
                dev-lang/python dev-libs/boost sys-devel/gettext \
                kde-frameworks/extra-cmake-modules sys-auth/polkit-qt6
            ;;
        *)
            echo -e "${RED}Distribuição não suportada automaticamente.${NC}"
            echo "Por favor, instale as dependências manualmente."
            ;;
    esac
}

# Copia arquivos
install_calamares() {
    echo -e "${YELLOW}Copiando arquivos do Calamares...${NC}"
    
    # Copia binário
    cp -r bin/* "$BIN_DIR/"
    
    # Copia bibliotecas
    cp -r lib/* "$LIB_DIR/"
    
    # Atualiza biblioteca cache
    ldconfig
    
    # Cria diretório de configuração
    mkdir -p /etc/calamares
    mkdir -p /usr/share/calamares
    
    echo -e "${GREEN}Arquivos copiados com sucesso!${NC}"
}

# Cria configuração padrão
create_config() {
    echo -e "${YELLOW}Criando configuração básica...${NC}"
    
    cat > /etc/calamares/settings.conf << 'EOF'
[General]
backend = "process"
distributionId = "linux"
locale = "en_US"
setBootloaderId = true
doChroot = true
showSupportURL = false
showReleaseNotes = false
hideBackButton = false
hideNextButton = false
hideCancelButton = false
quitOnCancel = false
dontExit = false
autologinUser = ""
shell = "/bin/bash"

[Steps]
showWelcome = true
showLicense = false
showDiskInfo = true
showPartition = true
showfsResize = false
showMount = true
showUnpack = false
showUsers = true
showPackages = true
showKeyboard = true
showSummary = true
showFinish = false

[ModulesOrder]
- welcome
- locale
- keyboard
- partition
- users
- packages
- summary
- finished
EOF
    
    echo -e "${GREEN}Configuração básica criada em /etc/calamares/${NC}"
}

# Menu principal
echo "Escolha uma opção:"
echo "1) Instalar dependências"
echo "2) Instalar Calamares"
echo "3) Criar configuração básica"
echo "4) Tudo (1+2+3)"
echo "5) Sair"
echo ""
read -p "Opção: " OPTION

case $OPTION in
    1)
        install_deps
        ;;
    2)
        install_calamares
        ;;
    3)
        create_config
        ;;
    4)
        install_deps
        install_calamares
        create_config
        ;;
    5)
        echo "Saindo..."
        exit 0
        ;;
    *)
        echo "Opção inválida"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}Pronto!${NC}"
echo "Execute 'calamares' para iniciar o instalador."
