# Temas para Calamares

Este diretório contém dois temas para o Calamares:
- **Default**: Tema clássico/padrão do Calamares
- **Modern**: Tema moderno com slideshow e estilos visuais atualizados

## Pré-visualização

### Tema Default
O tema padrão do Calamares com interface clássica.

Arquivos:
- `branding.desc` - Configuração do tema
- `logo.png` - Logo do sistema
- `show.qml` - Script de slideshow
- `preview.png` - Imagem de preview
- `languages.png` - Imagem de idiomas

### Tema Modern
Tema moderno com visual atualizado, ideal para distribuições contemporâneas.

Arquivos:
- `branding.desc` - Configuração do tema
- `logo.png` - Logo do sistema
- `stylesheet.qss` - Estilos CSS para Qt
- `preview.png` - Imagem de preview
- `slideshow/` - Apresentação de slides com:
  - Presentation.qml
  - Slide.qml
  - SlideCounter.qml
  - NavButton.qml
  - BackButton.qml
  - ForwardButton.qml

---

# COMO INSTALAR O TEMA

## Método 1: Script Interativo

Execute o script de seleção de tema:

```bash
cd themes
sudo bash select-theme.sh
```

Isso irá perguntar qual tema você deseja usar e instalará automaticamente.

## Método 2: Instalação Manual

### Para usar o tema Default:

```bash
# Copia o tema default para o diretório de branding do Calamares
sudo cp -r themes/default /usr/share/calamares/branding/default
```

### Para usar o tema Modern:

```bash
# Copia o tema moderno
sudo cp -r themes/modern /usr/share/calamares/branding/default

# Copia os arquivos de slideshow
sudo cp -r themes/modern/slideshow/* /usr/share/calamares/branding/default/slideshow/
```

---

# COMO PERSONALIZAR O TEMA

## Editando branding.desc

O arquivo `branding.desc` contém as configurações principais do tema:

```yaml
# Exemplo de branding.desc
productName: Minha Distribuição
productLogo: logo
version: 1.0
bootLoaderEntryName: minha-distro
```

### Opções disponíveis:

| Campo | Descrição |
|-------|-----------|
| productName | Nome do produto/distribuição |
| productLogo | Nome do arquivo de logo (sem extensão) |
| version | Versão do sistema |
| bootloaderEntryName | Nome no menu do bootloader |
| welcomeLogo | Logo na tela de boas-vindas |
| welcomeStyle | Estilo CSS adicional |
| welcomeBackground | Imagem de fundo |

## Editando o logo

Substitua o arquivo `logo.png` pelo logo da sua distribuição.

Tamanho recomendado: 64x64 pixels ou 128x128 pixels.

## Editando o stylesheet (apenas tema Modern)

O arquivo `stylesheet.qss` permite personalização via CSS:

```css
/* Exemplo de personalização */
QWidget {
    background-color: #2c3e50;
    color: #ecf0f1;
}

QPushButton {
    background-color: #3498db;
    border-radius: 5px;
    padding: 8px 16px;
}
```

---

# SLIDESHOW (Apenas tema Modern)

O tema moderno inclui uma apresentação de slides que aparece durante a instalação.

## Configuração

Para ativar o slideshow, adicione ao `branding.desc`:

```yaml
slideshow: true
```

## Slides Personalizados

Os slides são definidos em `slideshow/Presentation.qml`. Você pode modificar:

- Número de slides
- Conteúdo de cada slide
- Imagens e textos
- Transições
- Tempo de cada slide

---

# EXEMPLO: settings.conf

Para que o tema funcione corretamente, você precisa de um `settings.conf` adequado:

```yaml
[General]
backend = "process"
distributionId = "minha-distro"
showSupportURL = false
showReleaseNotes = false

[Steps]
showWelcome = true
showLicense = false
showDiskInfo = true
showPartition = true
showMount = true
showUsers = true
showPackages = true
showKeyboard = true
showSummary = true
showFinish = true
```

---

# COMPATIBILIDADE

| Tema | Qt5 | Qt6 |
|------|-----|-----|
| Default | ✅ | ✅ |
| Modern | ✅ | ✅ |

Ambos os temas são compatíveis com Calamares 3.3.x compilado com Qt5 ou Qt6.

---

# TROUBLESHOOTING

## Tema não aparece

1. Verifique se o tema está em:
   ```
   /usr/share/calamares/branding/default/
   ```

2. Execute o Calamares em modo debug:
   ```
   calamares -d
   ```

## Slideshow não funciona

1. Verifique se os arquivos do slideshow estão em:
   ```
   /usr/share/calamares/branding/default/slideshow/
   ```

2. Certifique-se de que o tema está definido corretamente no `branding.desc`

## Logo não aparece

1. Verifique se o arquivo se chama `logo.png` (não logo.svg ou outro formato)
2. O arquivo deve estar no diretório do tema

---

# CRÉDITOS

Temas baseados no Calamares Branding System.
