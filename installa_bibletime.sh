#!/usr/bin/env bash
# ==============================================================================
# BIBLETIME AI SCHOLAR SUITE - VISUAL INSTALLER FOR LINUX (Ubuntu/Debian/Fedora)
# Uses Zenity/Whiptail GUI + curl to download Python Standalone,
# BibleTime_AI_Suite.zip, generate .venv_linux, configure language (IT/EN/ES) & launch.
# Strictly under 140 lines.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_DIST="$(dirname "$SCRIPT_DIR")/dist_clienti"
GITHUB_BASE="https://github.com/scesho/BibleTime-AI-Scholar-Suite/releases/download/installer"
INSTALL_DIR="$HOME/.local/share/BibleTime_AI_Suite"
TMP_DIR="/tmp/BibleTime_Setup_Tmp"

LANG_CODE="it"
if command -v zenity &>/dev/null; then
    SEL=$(zenity --list --radiolist --title="BibleTime AI Scholar Suite — Setup" \
        --text="Seleziona la lingua predefinita / Select language / Selecciona idioma:" \
        --column="" --column="Codice" --column="Lingua" \
        TRUE "it" "🇮🇹 Italiano (Edizione Italiana)" \
        FALSE "en" "🇬🇧 English (KJV Scholar Suite)" \
        FALSE "es" "🇪🇸 Español (Reina-Valera Suite)" --width=480 --height=280 2>/dev/null)
    [ -z "$SEL" ] && exit 0
    LANG_CODE="$SEL"
elif command -v whiptail &>/dev/null; then
    SEL=$(whiptail --title "BibleTime AI Scholar Suite — Setup" --menu "Select language / Seleziona lingua:" 15 60 3 \
        "it" "Italiano (Edizione Italiana)" \
        "en" "English (KJV Scholar Suite)" \
        "es" "Español (Reina-Valera Suite)" 3>&1 1>&2 2>&3)
    [ -z "$SEL" ] && exit 0
    LANG_CODE="$SEL"
fi

mkdir -p "$INSTALL_DIR" "$TMP_DIR"

fetch_with_curl() {
    local fname="$1"
    local dest="$2"
    if [ -f "$LOCAL_DIST/$fname" ]; then
        curl -fSL "file://$LOCAL_DIST/$fname" -o "$dest" && return 0
    fi
    curl -fSL "$GITHUB_BASE/$fname" -o "$dest"
}

(
    echo "15" ; echo "# 1/5 • Download Python 3.12 Portatile Standalone (curl)..."
    if [ ! -x "$INSTALL_DIR/python_standalone/bin/python3" ]; then
        if fetch_with_curl "python_standalone_linux_x64.tar.gz" "$TMP_DIR/py_linux.tar.gz"; then
            mkdir -p "$INSTALL_DIR/python_standalone"
            tar -xzf "$TMP_DIR/py_linux.tar.gz" -C "$INSTALL_DIR/python_standalone" --strip-components=1
        fi
    fi

    echo "40" ; echo "# 2/5 • Download pacchetto universale BibleTime_AI_Suite.zip (curl)..."
    fetch_with_curl "BibleTime_AI_Suite.zip" "$TMP_DIR/BibleTime_AI_Suite.zip"

    echo "65" ; echo "# 3/5 • Estrazione Biblioteca Accademica e 348 moduli SWORD..."
    python3 -m zipfile -e "$TMP_DIR/BibleTime_AI_Suite.zip" "$INSTALL_DIR" 2>/dev/null || unzip -qo "$TMP_DIR/BibleTime_AI_Suite.zip" -d "$INSTALL_DIR"
    chmod +x "$INSTALL_DIR"/*.sh "$INSTALL_DIR"/*.command 2>/dev/null || true

    echo "85" ; echo "# 4/5 • Generazione automatica ambiente .venv_linux e librerie..."
    PY_BIN="$INSTALL_DIR/python_standalone/bin/python3"
    [ ! -x "$PY_BIN" ] && PY_BIN="python3"
    "$PY_BIN" -m venv "$INSTALL_DIR/.venv_linux"
    "$INSTALL_DIR/.venv_linux/bin/pip" install --upgrade pip -q
    "$INSTALL_DIR/.venv_linux/bin/pip" install -r "$INSTALL_DIR/requirements.txt" -q

    echo "95" ; echo "# 5/5 • Pre-configurazione lingua ($LANG_CODE) e icona Desktop..."
    for cfg in "$INSTALL_DIR/server/router/config.default.json" "$INSTALL_DIR/server/router/config.json"; do
        if [ -f "$cfg" ]; then
            "$INSTALL_DIR/.venv_linux/bin/python" -c "import json; p='$cfg'; d=json.load(open(p)); d['language']='$LANG_CODE'; json.dump(d, open(p,'w'), indent=2)"
        fi
    done
    if [ -f "$INSTALL_DIR/dist/index.html" ]; then
        "$INSTALL_DIR/.venv_linux/bin/python" -c "p='$INSTALL_DIR/dist/index.html'; h=open(p).read(); b=\"<script>localStorage.setItem('bibletime_lang','$LANG_CODE');localStorage.setItem('bibletime_app_language','$LANG_CODE');</script>\"; open(p,'w').write(h.replace('<head>','<head>'+b,1)) if 'bibletime_lang' not in h else None"
    fi

    DESKTOP_FILE="$HOME/Desktop/BibleTime_AI_Scholar_Suite.desktop"
    cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Type=Application
Name=BibleTime AI Scholar Suite
Exec=$INSTALL_DIR/avvia_linux.sh
Path=$INSTALL_DIR
Terminal=false
Categories=Education;
EOF
    chmod +x "$DESKTOP_FILE" 2>/dev/null || true
    echo "100" ; echo "# ✅ Installazione completata! Avvio in corso..."
) | (if command -v zenity &>/dev/null; then zenity --progress --title="BibleTime AI Scholar Suite — Setup" --width=500 --auto-close 2>/dev/null; else cat; fi)

"$INSTALL_DIR/avvia_linux.sh" &

