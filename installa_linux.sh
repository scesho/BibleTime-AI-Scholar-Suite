#!/usr/bin/env bash
# ==============================================================================
# BIBLETIME AI SCHOLAR SUITE — INSTALLER LINUX UNIVERSALE (Ubuntu/Debian/Fedora/Arch)
# Si auto-apre in una finestra di terminale se cliccato da interfaccia grafica.
# Esegue download con curl, unpack ZIP, setup Python 3.12 standalone e crea icona Desktop.
# Zero God Code: < 170 righe.
# ==============================================================================

# Se avviato senza terminale visibile (es. doppio clic su .sh da file manager) e solo se $0 è un file reale su disco
if [ ! -t 1 ] && [ -z "$BIBLETIME_IN_TERMINAL" ] && [ -f "$0" ]; then
    export BIBLETIME_IN_TERMINAL=1
    SCRIPT_PATH="$(cd "$(dirname "$0")" 2>/dev/null && pwd)/$(basename "$0")"
    for term in gnome-terminal xfce4-terminal konsole mate-terminal xterm alacritty kitty; do
        if command -v "$term" &>/dev/null; then
            case "$term" in
                gnome-terminal)
                    exec gnome-terminal --title="BibleTime AI Suite — Setup" -- bash -c "\"$SCRIPT_PATH\" \"$@\"; echo; read -p 'Premi INVIO per uscire...' -n 1 -r"
                    ;;
                xfce4-terminal|mate-terminal)
                    exec "$term" --title="BibleTime AI Suite — Setup" -e "bash -c '\"$SCRIPT_PATH\" \"$@\"; echo; read -p \"Premi INVIO per uscire...\" -n 1 -r'"
                    ;;
                konsole)
                    exec konsole -p tabtitle="BibleTime AI Suite — Setup" -e bash -c "\"$SCRIPT_PATH\" \"$@\"; echo; read -p 'Premi INVIO per uscire...' -n 1 -r"
                    ;;
                xterm|alacritty|kitty)
                    exec "$term" -e bash -c "\"$SCRIPT_PATH\" \"$@\"; echo; read -p 'Premi INVIO per uscire...' -n 1 -r"
                    ;;
            esac
        fi
    done
fi

clear
echo "======================================================================"
echo "    BIBLETIME AI SCHOLAR SUITE — INSTALLAZIONE LINUX OFFLINE"
echo "======================================================================"
echo

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_DIST="$(dirname "$SCRIPT_DIR")/dist_clienti"
GITHUB_BASE="https://github.com/scesho/BibleTime-AI-Scholar-Suite/releases/download/installer"
INSTALL_DIR="$HOME/.local/share/BibleTime_AI_Suite"
TMP_DIR="/tmp/BibleTime_Setup_Tmp"

# Selezione Lingua (GUI se disponibile, altrimenti da terminale interattivo)
LANG_CODE="it"
if command -v zenity &>/dev/null; then
    SEL=$(zenity --list --radiolist --title="BibleTime AI Scholar Suite — Setup" \
        --text="Seleziona la lingua predefinita / Select language / Selecciona idioma:" \
        --column="" --column="Codice" --column="Lingua" \
        TRUE "it" "🇮🇹 Italiano (Edizione Italiana)" \
        FALSE "en" "🇬🇧 English (KJV Scholar Suite)" \
        FALSE "es" "🇪🇸 Español (Reina-Valera Suite)" --width=480 --height=280 2>/dev/null)
    [ -n "$SEL" ] && LANG_CODE="$SEL"
elif [ -t 0 ]; then
    echo "Seleziona la lingua / Select language / Selecciona idioma:"
    echo "  [1] Italiano (Predefinita)"
    echo "  [2] English (KJV Scholar Suite)"
    echo "  [3] Español (Reina-Valera Suite)"
    read -p "Digita 1, 2 o 3 [Default: 1]: " SCELTA
    case "$SCELTA" in
        2) LANG_CODE="en" ;;
        3) LANG_CODE="es" ;;
        *) LANG_CODE="it" ;;
    esac
fi

echo
echo "[*] Lingua selezionata: $LANG_CODE"
echo "[*] Destinazione installazione: $INSTALL_DIR"
mkdir -p "$INSTALL_DIR" "$TMP_DIR"

fetch_file() {
    local fname="$1"
    local dest="$2"
    if [ -f "$LOCAL_DIST/$fname" ]; then
        cp -f "$LOCAL_DIST/$fname" "$dest" && return 0
    elif [ -f "$SCRIPT_DIR/$fname" ]; then
        cp -f "$SCRIPT_DIR/$fname" "$dest" && return 0
    fi
    echo "[↓] Download $fname da GitHub..."
    curl -fSL --progress-bar "$GITHUB_BASE/$fname" -o "$dest"
}

# 1. Python Standalone
echo
echo "[1/5] Verifica Python 3.12 Standalone..."
if [ ! -x "$INSTALL_DIR/python_standalone/bin/python3" ]; then
    fetch_file "python_standalone_linux_x64.tar.gz" "$TMP_DIR/py_linux.tar.gz"
    echo "[*] Estrazione runtime Python..."
    mkdir -p "$INSTALL_DIR/python_standalone"
    tar -xzf "$TMP_DIR/py_linux.tar.gz" -C "$INSTALL_DIR/python_standalone" --strip-components=1
fi

# 2. Pacchetto Universale
echo
echo "[2/5] Recupero pacchetto software BibleTime_AI_Suite.zip..."
fetch_file "BibleTime_AI_Suite.zip" "$TMP_DIR/BibleTime_AI_Suite.zip"

# 3. Estrazione
echo
echo "[3/5] Estrazione Suite, 518 moduli SWORD e database esegetici..."
python3 -m zipfile -e "$TMP_DIR/BibleTime_AI_Suite.zip" "$INSTALL_DIR" 2>/dev/null || unzip -qo "$TMP_DIR/BibleTime_AI_Suite.zip" -d "$INSTALL_DIR"
chmod +x "$INSTALL_DIR"/*.sh "$INSTALL_DIR"/*.command 2>/dev/null || true

# 4. Ambiente Virtuale
echo
echo "[4/5] Configurazione ambiente Python .venv_linux e dipendenze..."
PY_BIN="$INSTALL_DIR/python_standalone/bin/python3"
[ ! -x "$PY_BIN" ] && PY_BIN="$(command -v python3)"
"$PY_BIN" -m venv "$INSTALL_DIR/.venv_linux"
"$INSTALL_DIR/.venv_linux/bin/pip" install --upgrade pip -q
"$INSTALL_DIR/.venv_linux/bin/pip" install -r "$INSTALL_DIR/requirements.txt" -q

# 5. Configurazione Lingua & Icona Desktop
echo
echo "[5/5] Configurazione finale e creazione icona sul Desktop..."
for cfg in "$INSTALL_DIR/server/router/config.default.json" "$INSTALL_DIR/server/router/config.json"; do
    if [ -f "$cfg" ]; then
        "$INSTALL_DIR/.venv_linux/bin/python" -c "import json; p='$cfg'; d=json.load(open(p)); d['language']='$LANG_CODE'; json.dump(d, open(p,'w'), indent=2)" 2>/dev/null || true
    fi
done

if [ -f "$INSTALL_DIR/dist/index.html" ]; then
    "$INSTALL_DIR/.venv_linux/bin/python" -c "p='$INSTALL_DIR/dist/index.html'; h=open(p).read(); b=\"<script>localStorage.setItem('bibletime_lang','$LANG_CODE');localStorage.setItem('bibletime_app_language','$LANG_CODE');</script>\"; open(p,'w').write(h.replace('<head>','<head>'+b,1)) if 'bibletime_lang' not in h else None" 2>/dev/null || true
fi

# Rilevamento dinamico cartella Desktop (supporta Scrivania, Desktop, Escritorio)
DESKTOP_DIR=""
if command -v xdg-user-dir &>/dev/null; then
    DESKTOP_DIR="$(xdg-user-dir DESKTOP 2>/dev/null)"
fi
[ -z "$DESKTOP_DIR" ] && [ -d "$HOME/Desktop" ] && DESKTOP_DIR="$HOME/Desktop"
[ -z "$DESKTOP_DIR" ] && [ -d "$HOME/Scrivania" ] && DESKTOP_DIR="$HOME/Scrivania"
[ -z "$DESKTOP_DIR" ] && [ -d "$HOME/Escritorio" ] && DESKTOP_DIR="$HOME/Escritorio"
[ -z "$DESKTOP_DIR" ] && DESKTOP_DIR="$HOME"

# Copia icona grafica ad alta definizione
ICON_PATH="$INSTALL_DIR/app.png"
[ ! -f "$ICON_PATH" ] && fetch_file "app.png" "$ICON_PATH" 2>/dev/null || true

DESKTOP_FILE="$DESKTOP_DIR/BibleTime_AI_Scholar_Suite.desktop"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=BibleTime AI Scholar Suite
GenericName=Accademia Esegetica & Biblioteca Teologica AI
Comment=Suite esegetica accademica avanzata con 518 moduli SWORD e intelligenza artificiale
Exec=$INSTALL_DIR/avvia_linux.sh
Path=$INSTALL_DIR
Icon=$ICON_PATH
Terminal=false
Categories=Education;Science;Religion;
StartupWMClass=BibleTime AI
EOF

chmod +x "$DESKTOP_FILE" 2>/dev/null || true
# Consenti l'avvio immediato su GNOME/Ubuntu senza avvisi di sicurezza
if command -v gio &>/dev/null; then
    gio set "$DESKTOP_FILE" metadata::trusted true 2>/dev/null || true
    gio set "$DESKTOP_FILE" "metadata::trusted" yes 2>/dev/null || true
fi

# Registra anche nel menu Applicazioni di sistema Linux (~/.local/share/applications)
USER_APPS="$HOME/.local/share/applications"
if [ -d "$USER_APPS" ]; then
    cp -f "$DESKTOP_FILE" "$USER_APPS/BibleTime_AI_Scholar_Suite.desktop" 2>/dev/null || true
    update-desktop-database "$USER_APPS" 2>/dev/null || true
fi

# Pulizia temporanei
rm -rf "$TMP_DIR"

echo
echo "======================================================================"
echo "    INSTALLAZIONE COMPLETATA CON SUCCESSO! AVVIO IN CORSO..."
echo "======================================================================"
echo

if [ -x "$INSTALL_DIR/avvia_linux.sh" ]; then
    nohup "$INSTALL_DIR/avvia_linux.sh" >/dev/null 2>&1 &
fi

