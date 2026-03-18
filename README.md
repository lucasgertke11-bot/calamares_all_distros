# Calamares Puro - Instalador Universal

Este é o Calamares compilado de forma "pura", sem configurações específicas de nenhuma distribuição. O objetivo é ter uma base que funcione em qualquer distro Linux, bastando adicionar os arquivos específicos de cada distribuição.

## Estrutura

```
calamares-puro/
├── bin/
│   └── calamares          # Binário principal
├── lib/
│   ├── libcalamares.so.3.3.14
│   ├── libcalamares.so.3.3
│   └── libcalamares.so
├── share/
│   └── calamares/         # Módulos e configurações
└── README.md
```

## O que é o Calamares?

Calamares é um framework de instalação independente de distribuição. Ele é usado por várias distribuições Linux como installer padrão.

## Compatibilidade

Este Calamares foi compilado no **Ubuntu 25.10** usando **Qt6**.

### Distribuições Compatíveis (teoricamente)

- Ubuntu e derivados (Kubuntu, Lubuntu, Xubuntu, etc.)
- Debian e derivados
- Fedora
- openSUSE
- Arch Linux
- Gentoo
- Manjaro
- Chakra
- EndeavourOS
- KaOS
- elementary OS
- Solus
- Zorin OS
- Pop!_OS

**Nota:** Para funcionar em cada distro, você precisa instalar as dependências específicas e configurar os arquivos específicos de cada distribuição.

---

# GUIA COMPLETO POR DISTROIAÇÃO

## Dependências Universais (todas as distros)

Todas as distribuições precisam ter estas bibliotecas instaladas:

### Bibliotecas Qt6
- libQt6Core
- libQt6Widgets
- libQt6Gui
- libQt6Xml
- libQt6Network
- libQt6Sql
- libQt6Svg
- libQt6Test
- libQt6Concurrent
- libQt6OpenGL
- libQt6XmlPatterns
- libQt6WebEngine (opcional)
- libQt6Quick
- libQt6Qml
- libQt6DBus

### Bibliotecas KDE Frameworks 6
- libKF6CoreAddons
- libKF6I18n
- libKF6WidgetsAddons
- libKF6Config
- libKF6Service
- libKF6DBusAddons
- libKF6Solid
- libKF6Package
- libKF6Crash

### Outras bibliotecas
- libparted (gerenciamento de partições)
- libkpmcore (KDE Partition Manager)
- libyaml-cpp (parsing YAML)
- libcrypt (criptografia)
- libpwquality (qualidade de senha)
- libicu (internacionalização)
- libutempter (gerenciamento de terminal)

---

## UBUNTU E DEBIAN

### Instalação de dependências (Ubuntu/Debian)

```bash
# Ubuntu
sudo apt install calamares

# Dependencies necessárias
sudo apt install \
    qt6-base-dev \
    qt6-tools-dev \
    libqt6svg6-dev \
    libqt6xmlpatterns6-dev \
    libkf6coreaddons-dev \
    libkf6i18n-dev \
    libkf6widgetsaddons-dev \
    libkf6config-dev \
    libkf6service-dev \
    libkf6dbusaddons-dev \
    libkf6solid-dev \
    libkf6package-dev \
    libkf6crash-dev \
    libkf6iconthemes-dev \
    libkf6kio-dev \
    libkf6parts-dev \
    libkpmcore-dev \
    libparted-dev \
    libyaml-cpp-dev \
    libcrypt-dev \
    libpwquality-dev \
    libicu-dev \
    libboost-python-dev \
    python3-dev \
    gettext \
    extra-cmake-modules \
    libpolkit-qt6-1-dev \
    libatasmart-dev \
    libappstreamqt-dev \
    libplasma-dev
```

### Configuração específica Ubuntu/Debian

Após copiar o Calamares puro, você precisa:

1. **Arquivo de configuração principal:**
   ```bash
   sudo cp config/ubuntu/settings.conf /etc/calamares/
   ```

2. **Módulos específicos:**
   - `packages` - usa APT/Dpkg
   - `bootloader` - GRUB
   - `users` - usuários Linux padrão
   - `locale` - localização
   - `keyboard` - layout de teclado

3. **Configurações de locale:**
   ```yaml
   # /etc/calamares/modules/locale.conf
   backend: "APT"
   ```

4. **Configurações de pacotes:**
   ```yaml
   # /etc/calamares/modules/packages.conf
   backend: apt
   update-db-tool: apt-get
   update-tool: apt-get
   ```

---

## FEDORA

### Instalação de dependências (Fedora)

```bash
sudo dnf install \
    qt6-qtbase \
    qt6-qtbase-gui \
    qt6-qtbase-common \
    qt6-qttools \
    qt6-qtsvg \
    qt6-qtxmlpatterns \
    kf6-kcoreaddons \
    kf6-ki18n \
    kf6-kwidgetsaddons \
    kf6-kconfig \
    kf6-kservice \
    kf6-kdbusaddons \
    kf6-solid \
    kf6-kpackage \
    kf6-kcrash \
    kf6-kiconthemes \
    kf6-kio \
    kf6-kparts \
    libparted \
    kpmcore \
    libyaml-cpp \
    libpwquality \
    python3-devel \
    boost-python \
    gettext \
    extra-cmake-modules \
    polkit-qt6 \
    libatasmart \
    appstream-qt
```

### Configuração específica Fedora

1. **Configurações de pacotes:**
   ```yaml
   # /etc/calamares/modules/packages.conf
   backend: dnf
   update-db-tool: dnf
   update-tool: dnf
   ```

2. **Módulos específicos:**
   - `packages` - usa DNF/YUM
   - `bootloader` - GRUB2
   - `services-systemd` - systemd
   - `dracut` - initramfs

3. **GRUB:**
   ```yaml
   # /etc/calamares/modules/bootloader.conf
   bootloaderName: grub2
   installForUEFI: true
   ```

---

## ARCH LINUX

### Instalação de dependências (Arch)

```bash
sudo pacman -S --needed \
    qt6-base \
    qt6-tools \
    qt6-svg \
    qt6-xmlpatterns \
    kf6-kcoreaddons \
    kf6-ki18n \
    kf6-kwidgetsaddons \
    kf6-kconfig \
    kf6-kservice \
    kf6-kdbusaddons \
    kf6-solid \
    kf6-kpackage \
    kf6-kcrash \
    kf6-kiconthemes \
    kf6-kio \
    kf6-kparts \
    parted \
    kpmcore \
    libyaml-cpp \
    libpwquality \
    python \
    boost \
    gettext \
    extra-cmake-modules \
    polkit-qt6 \
    libatasmart \
    appstream
```

### Configuração específica Arch Linux

1. **Configurações de pacotes:**
   ```yaml
   # /etc/calamares/modules/packages.conf
   backend: pacman
   ```

2. **Módulos específicos:**
   - `packages` - usa Pacman
   - `bootloader` - GRUB/systemd-boot
   - `initcpio` - initramfs
   - `services-systemd` - systemd

3. **mkinitcpio:**
   ```yaml
   # /etc/calamares/modules/initcpio.conf
   presets:
     - mkinitcpio-all
   ```

---

## OPENSUSE

### Instalação de dependências (openSUSE)

```bash
sudo zypper install \
    libqt6-qtbase6 \
    libqt6-qttools \
    libqt6-qtsvg \
    libqt6-qtxmlpatterns \
    libKF6CoreAddons6 \
    libKF6I18n6 \
    libKF6WidgetsAddons6 \
    libKF6Config6 \
    libKF6Service6 \
    libKF6DBusAddons6 \
    libKF6Solid6 \
    libKF6Package6 \
    libKF6Crash6 \
    libKF6IconThemes6 \
    libKF6KIO6 \
    libKF6Parts6 \
    libparted0 \
    libkpmcore9 \
    libyaml-cpp0 \
    libpwquality1 \
    python310-devel \
    libboost_python3_1_84_0 \
    gettext-tools \
    extra-cmake-modules \
    libpolkit-qt6-1 \
    libatasmart0 \
    libappstream-qt5
```

### Configuração específica openSUSE

1. **Configurações de pacotes:**
   ```yaml
   # /etc/calamares/modules/packages.conf
   backend: zypp
   ```

2. **Módulos específicos:**
   - `packages` - usa ZYpp
   - `bootloader` - GRUB2
   - `dracut` - initramfs

---

## GENTOO

### Instalação de dependências (Gentoo)

```bash
# Instale os pacotes necessários
sudo emerge --ask \
    dev-qt/qtbase \
    dev-qt/qttools \
    dev-qt/qtsvg \
    dev-qt/qtxmlpatterns \
    kde-frameworks/kcoreaddons \
    kde-frameworks/ki18n \
    kde-frameworks/kwidgetsaddons \
    kde-frameworks/kconfig \
    kde-frameworks/kservice \
    kde-frameworks/kdbusaddons \
    kde-frameworks/solid \
    kde-frameworks/kpackage \
    kde-frameworks/kcrash \
    kde-frameworks/kiconthemes \
    kde-frameworks/kio \
    kde-frameworks/kparts \
    sys-block/parted \
    kde-apps/kpmcore \
    dev-cpp/yaml-cpp \
    libpwquality \
    dev-lang/python \
    dev-libs/boost \
    sys-devel/gettext \
    kde-frameworks/extra-cmake-modules \
    sys-auth/polkit-qt6
```

### Configuração específica Gentoo

1. **Configurações de pacotes:**
   ```yaml
   # /etc/calamares/modules/packages.conf
   backend: portage
   ```

2. **Módulos específicos:**
   - `packages` - usa Emerge/Portage
   - `bootloader` - GRUB2
   - `initcpio` - não use (Gentoo usa/genkernel)

---

## MANJARO

### Instalação de dependências (Manjaro)

Igual ao Arch Linux, mas alguns pacotes podem ter nomes diferentes:

```bash
sudo pacman -S --needed \
    qt6-base \
    qt6-tools \
    qt6-svg \
    qt6-xmlpatterns \
    kf6-kcoreaddons \
    kf6-ki18n \
    kf6-kwidgetsaddons \
    kf6-kconfig \
    kf6-kservice \
    kf6-kdbusaddons \
    kf6-solid \
    kf6-kpackage \
    kf6-kcrash \
    kf6-kiconthemes \
    kf6-kio \
    kf6-kparts \
    parted \
    kpmcore \
    libyaml-cpp \
    libpwquality \
    python \
    boost \
    gettext \
    extra-cmake-modules \
    polkit-qt6 \
    libatasmart \
    appstream
```

### Configuração específica Manjaro

Igual ao Arch Linux. Manjaro usa Pamac como gerenciador de pacotes padrão.

---

## SOLUS

### Instalação de dependências (Solus)

```bash
sudo eopkg install \
    qt6-base \
    qt6-tools \
    qt6-svg \
    qt6-xmlpatterns \
    kf6-kcoreaddons \
    kf6-ki18n \
    kf6-kwidgetsaddons \
    kf6-kconfig \
    kf6-kservice \
    kf6-kdbusaddons \
    kf6-solid \
    kf6-kpackage \
    kf6-kcrash \
    kf6-kiconthemes \
    kf6-kio \
    kf6-kparts \
    parted \
    kpmcore \
    libyaml-cpp \
    libpwquality \
    python3 \
    boost-python3 \
    gettext \
    extra-cmake-modules \
    polkit-qt6
```

---

## ELEMENTARY OS

### Instalação de dependências (elementary OS)

Igual ao Ubuntu/Debian, mas provavelmente precisará de algumas adaptações.

---

## ZORIN OS / POP!_OS

### Instalação de dependências

Igual ao Ubuntu. Ambas são baseadas no Ubuntu.

---

# ARQUIVOS NECESSÁRIOS PARA CADA DISTRO

## Estrutura de arquivos de configuração

Para cada distro, você precisa criar/editar:

```
/etc/calamares/
├── settings.conf          # Configuração principal
└── modules/
    ├── bootloader.conf    # Configuração do bootloader
    ├── packages.conf      # Configuração de pacotes
    ├── users.conf         # Configuração de usuários
    ├── locale.conf        # Configuração de localização
    ├── keyboard.conf      # Configuração de teclado
    ├── fstab.conf         # Configuração de montagem
    ├── services-systemd.conf  # Configuração de serviços
    └── [outros módulos]
```

## Módulos por distro

| Módulo | Ubuntu/Debian | Fedora | Arch | openSUSE | Gentoo |
|--------|---------------|--------|------|----------|--------|
| packages | apt | dnf | pacman | zypp | portage |
| bootloader | grub | grub2 | grub/systemd-boot | grub2 | grub2 |
| initramfs | - | dracut | mkinitcpio | dracut | - |
| services | systemd | systemd | systemd | systemd | OpenRC |

---

# COMPILANDO O CALAMARES

Se você quiser compilar sua própria versão:

## Dependências de build (Ubuntu)

```bash
sudo apt install \
    cmake \
    qt6-base-dev \
    qt6-tools-dev \
    qt6-svg-dev \
    qt6-xmlpatterns-dev \
    qt6-declarative-dev \
    qt6-webengine-dev \
    libkf6coreaddons-dev \
    libkf6i18n-dev \
    libkf6widgetsaddons-dev \
    libkf6config-dev \
    libkf6service-dev \
    libkf6dbusaddons-dev \
    libkf6solid-dev \
    libkf6package-dev \
    libkf6crash-dev \
    libkf6iconthemes-dev \
    libkf6kio-dev \
    libkf6parts-dev \
    libkpmcore-dev \
    libparted-dev \
    libyaml-cpp-dev \
    libcrypt-dev \
    libpwquality-dev \
    libboost-python-dev \
    python3-dev \
    gettext \
    extra-cmake-modules \
    libpolkit-qt6-1-dev \
    libatasmart-dev \
    libappstreamqt-dev \
    libplasma-dev
```

## Compilando

```bash
git clone https://github.com/calamares/calamares.git
cd calamares
mkdir build && cd build
cmake -DCMAKE_BUILD_TYPE=Release -DWITH_QT6=ON ..
make -j$(nproc)
sudo make install
```

---

# NOTAS IMPORTANTES

1. **Este Calamares usa Qt6** - Certifique-se de que sua distro tem Qt6 disponível

2. **Bibliotecas compatíveis** - Para funcionar em outra distro, as bibliotecas precisam ser compatíveis (versão glibc >= 2.34 recomendada)

3. **Arquivos de configuração** - O Calamares SEMPRE precisa de arquivos de configuração específicos da distro para funcionar

4. **Scripts de instalação** - Cada distro tem seus próprios scripts de pós-instalação que precisam ser configurados

5. **Módulos** - Alguns módulos podem não funcionar em todas as distros (ex: dracut só funciona em Fedora/openSUSE)

---

# LICENSE

Calamares é distribuído sob licença LGPL-2.1+. Veja o arquivo LICENSE para mais detalhes.

---

# FONTES

- Site oficial: https://calamares.io
- GitHub: https://github.com/calamares/calamares
- Documentação: https://calamares.euroquis.nl/docs/
