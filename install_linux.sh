#!/usr/bin/env bash
# ==============================================================================
# BIBLETIME AI SCHOLAR SUITE — INSTALLER LINUX UNIVERSALE (Ubuntu/Debian/Mint/Arch)
# Rileva Python nativo o standalone, decomprime lo zip e configura Desktop e avvio.
# Zero God Code: < 170 righe.
# ==============================================================================

if [ ! -t 1 ] && [ -z "$BIBLETIME_IN_TERMINAL" ] && [ -f "$0" ]; then
    export BIBLETIME_IN_TERMINAL=1
    SCRIPT_PATH="$(cd "$(dirname "$0")" 2>/dev/null && pwd)/$(basename "$0")"
    for term in gnome-terminal xfce4-terminal konsole mate-terminal xterm alacritty kitty; do
        if command -v "$term" &>/dev/null; then
            exec "$term" -- bash -c "\"$SCRIPT_PATH\" \"$@\"; echo; read -p 'Premi INVIO per uscire...' -n 1 -r"
        fi
    done
fi

clear
echo "======================================================================"
echo "    BIBLETIME AI SCHOLAR SUITE — INSTALLAZIONE LINUX OFFLINE"
echo "======================================================================"
echo

SCRIPT_DIR="$(cd "$(dirname "$0")" 2>/dev/null && pwd)"
LOCAL_DIST="$(dirname "$SCRIPT_DIR")/dist_clienti"
GITHUB_BASE="https://github.com/scesho/BibleTime-AI-Scholar-Suite/releases/download/installer"
INSTALL_DIR="$HOME/.local/share/BibleTime_AI_Suite"
TMP_DIR="/tmp/BibleTime_Setup_Tmp"

# Selezione Lingua
LANG_CODE="it"
if command -v zenity &>/dev/null; then
    SEL=$(zenity --list --radiolist --title="BibleTime AI Suite — Setup" \
        --text="Seleziona lingua / Select language:" --column="" --column="Codice" --column="Lingua" \
        TRUE "it" "Italiano" FALSE "en" "English" FALSE "es" "Español" --width=400 --height=240 2>/dev/null)
    [ -n "$SEL" ] && LANG_CODE="$SEL"
elif [ -t 0 ]; then
    echo "Seleziona lingua: [1] Italiano  [2] English  [3] Español"
    read -p "Scelta [Default: 1]: " SCELTA
    [ "$SCELTA" = "2" ] && LANG_CODE="en"
    [ "$SCELTA" = "3" ] && LANG_CODE="es"
fi

echo "[*] Lingua: $LANG_CODE | Destinazione: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR" "$TMP_DIR"

fetch_file() {
    local fname="$1" dest="$2"
    for src in "$LOCAL_DIST/$fname" "$SCRIPT_DIR/$fname" "$HOME/Scaricati/$fname" "$HOME/Downloads/$fname"; do
        if [ -f "$src" ]; then
            echo "[*] Trovato $fname in locale ($src)!"
            cp -f "$src" "$dest" && return 0
        fi
    done
    echo "[↓] Download $fname da GitHub..."
    curl -fSL --progress-bar "$GITHUB_BASE/$fname" -o "$dest"
}

# 1. Rilevamento e Setup Runtime Python
echo -e "\n[1/5] Rilevamento runtime Python 3..."
PY_BIN=""
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')" 2>/dev/null)
    if [ "${PY_VER%%.*}" -ge 3 ] && [ "${PY_VER##*.}" -ge 10 ]; then
        PY_BIN="$(command -v python3)"
        echo "[*] Trovato Python di sistema ottimizzato: $PY_BIN (v$PY_VER)"
    fi
fi
if [ -z "$PY_BIN" ]; then
    echo "[*] Utilizzo runtime Python 3.12 Standalone..."
    [ ! -x "$INSTALL_DIR/python_standalone/bin/python3" ] && fetch_file "python_standalone_linux_x64.tar.gz" "$TMP_DIR/py_linux.tar.gz" && mkdir -p "$INSTALL_DIR/python_standalone" && tar -xzf "$TMP_DIR/py_linux.tar.gz" -C "$INSTALL_DIR/python_standalone" --strip-components=1
    PY_BIN="$INSTALL_DIR/python_standalone/bin/python3"
fi

# 2. Pacchetto Universale ZIP
echo -e "\n[2/5] Recupero pacchetto biblioteca BibleTime_AI_Suite.zip..."
fetch_file "BibleTime_AI_Suite.zip" "$TMP_DIR/BibleTime_AI_Suite.zip"

ZIP_SIZE=$(stat -c%s "$TMP_DIR/BibleTime_AI_Suite.zip" 2>/dev/null || stat -f%z "$TMP_DIR/BibleTime_AI_Suite.zip" 2>/dev/null || echo 0)
if [ ! -f "$TMP_DIR/BibleTime_AI_Suite.zip" ] || [ "$ZIP_SIZE" -lt 10000000 ]; then
    echo -e "\n[AVVISO] BibleTime_AI_Suite.zip non presente o download incompleto."
    echo "Copia 'BibleTime_AI_Suite.zip' nella cartella 'Scaricati' e rilancia!"
    exit 1
fi

# 3. Estrazione
echo -e "\n[3/5] Estrazione Suite, 518 moduli SWORD e database esegetici..."
python3 -m zipfile -e "$TMP_DIR/BibleTime_AI_Suite.zip" "$INSTALL_DIR" 2>/dev/null || unzip -qo "$TMP_DIR/BibleTime_AI_Suite.zip" -d "$INSTALL_DIR"
chmod +x "$INSTALL_DIR"/*.sh "$INSTALL_DIR"/*.command 2>/dev/null || true

# 4. Ambiente Virtuale e Dipendenze
echo -e "\n[4/5] Configurazione ambiente Python e dipendenze..."
VENV_DIR="$INSTALL_DIR/.venv_linux"
[ ! -x "$VENV_DIR/bin/python" ] && ("$PY_BIN" -m venv --copies "$VENV_DIR" 2>/dev/null || "$PY_BIN" -m venv "$VENV_DIR" 2>/dev/null || true)

if [ -x "$VENV_DIR/bin/pip" ]; then
    "$VENV_DIR/bin/pip" install --upgrade pip -q 2>/dev/null || true
    "$VENV_DIR/bin/pip" install -r "$INSTALL_DIR/requirements.txt" -q 2>/dev/null || true
elif [ -x "$VENV_DIR/bin/python" ]; then
    "$VENV_DIR/bin/python" -m pip install -r "$INSTALL_DIR/requirements.txt" -q 2>/dev/null || true
else
    echo "[*] Installazione dipendenze a livello utente ($PY_BIN -m pip --user)..."
    "$PY_BIN" -m pip install -r "$INSTALL_DIR/requirements.txt" --user -q 2>/dev/null || true
    mkdir -p "$VENV_DIR/bin" && ln -sf "$PY_BIN" "$VENV_DIR/bin/python"
fi

# 5. Configurazione Lingua & Icona Desktop
echo -e "\n[5/5] Configurazione finale e creazione icona sul Desktop..."
for cfg in "$INSTALL_DIR/server/router/config.default.json" "$INSTALL_DIR/server/router/config.json"; do
    [ -f "$cfg" ] && "$VENV_DIR/bin/python" -c "import json; p='$cfg'; d=json.load(open(p)); d['language']='$LANG_CODE'; json.dump(d, open(p,'w'), indent=2)" 2>/dev/null || true
done
[ -f "$INSTALL_DIR/dist/index.html" ] && "$VENV_DIR/bin/python" -c "p='$INSTALL_DIR/dist/index.html'; h=open(p).read(); b=\"<script>localStorage.setItem('bibletime_lang','$LANG_CODE');localStorage.setItem('bibletime_app_language','$LANG_CODE');</script>\"; open(p,'w').write(h.replace('<head>','<head>'+b,1)) if 'bibletime_lang' not in h else None" 2>/dev/null || true

DESKTOP_DIR=""
command -v xdg-user-dir &>/dev/null && DESKTOP_DIR="$(xdg-user-dir DESKTOP 2>/dev/null)"
[ -z "$DESKTOP_DIR" ] && [ -d "$HOME/Desktop" ] && DESKTOP_DIR="$HOME/Desktop"
[ -z "$DESKTOP_DIR" ] && [ -d "$HOME/Scrivania" ] && DESKTOP_DIR="$HOME/Scrivania"
[ -z "$DESKTOP_DIR" ] && [ -d "$HOME/Escritorio" ] && DESKTOP_DIR="$HOME/Escritorio"
[ -z "$DESKTOP_DIR" ] && DESKTOP_DIR="$HOME"

ICON_PATH="$INSTALL_DIR/app.png"
[ ! -f "$ICON_PATH" ] && fetch_file "app.png" "$ICON_PATH" 2>/dev/null || true
chmod 644 "$ICON_PATH" 2>/dev/null || true

# Registra anche nel tema icone utente standard di Linux
mkdir -p "$HOME/.local/share/icons/hicolor/256x256/apps" 2>/dev/null || true
[ -f "$ICON_PATH" ] && cp -f "$ICON_PATH" "$HOME/.local/share/icons/hicolor/256x256/apps/bibletime.png" 2>/dev/null || true
command -v gtk-update-icon-cache &>/dev/null && gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true

DESKTOP_FILE="$DESKTOP_DIR/BibleTime_AI_Scholar_Suite.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=BibleTime AI Scholar Suite
GenericName=Accademia Esegetica & Biblioteca Teologica AI
Comment=Suite esegetica accademica avanzata con 518 moduli SWORD e AI
Exec=$INSTALL_DIR/avvia_linux.sh
Path=$INSTALL_DIR
Icon=$ICON_PATH
Terminal=false
Categories=Education;Science;Religion;
StartupWMClass=BibleTime AI
EOF

chmod a+x "$DESKTOP_FILE" 2>/dev/null || true
command -v gio &>/dev/null && gio set "$DESKTOP_FILE" metadata::trusted true 2>/dev/null || true
command -v gio &>/dev/null && gio set "$DESKTOP_FILE" "metadata::trusted" yes 2>/dev/null || true

USER_APPS="$HOME/.local/share/applications"
[ -d "$USER_APPS" ] && cp -f "$DESKTOP_FILE" "$USER_APPS/BibleTime_AI_Scholar_Suite.desktop" 2>/dev/null || true
rm -rf "$TMP_DIR"

echo -e "\n======================================================================"
echo "    INSTALLAZIONE COMPLETATA CON SUCCESSO! AVVIO IN CORSO..."
echo "======================================================================"
echo
[ -x "$INSTALL_DIR/avvia_linux.sh" ] && nohup "$INSTALL_DIR/avvia_linux.sh" >/dev/null 2>&1 &
