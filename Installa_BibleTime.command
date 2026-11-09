#!/usr/bin/env bash
# ==============================================================================
# BIBLETIME AI SCHOLAR SUITE - VISUAL INSTALLER FOR macOS (Apple Silicon & Intel)
# Uses native macOS GUI dialogs (osascript) + curl to download Python Standalone,
# BibleTime_AI_Suite.zip, generate .venv_mac, configure language (IT/EN/ES) & launch.
# Strictly under 140 lines.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOCAL_DIST="$(dirname "$SCRIPT_DIR")/dist_clienti"
GITHUB_BASE="https://github.com/scesho/BibleTime-AI-Scholar-Suite/releases/download/installer"
INSTALL_DIR="$HOME/Applications/BibleTime_AI_Suite"
TMP_DIR="/tmp/BibleTime_Setup_Tmp"

xattr -dr com.apple.quarantine "$SCRIPT_DIR" 2>/dev/null || true

# 1. Finestra Grafica Nativa macOS per Scelta Lingua (Italiano / English / Español)
CHOICE=$(osascript -e 'choose from list {"🇮🇹 Italiano", "🇬🇧 English", "🇪🇸 Español"} with title "BibleTime AI Scholar Suite — Setup" with prompt "Seleziona la lingua del software / Select your language / Selecciona tu idioma:" default items {"🇮🇹 Italiano"}' 2>/dev/null)

if [ "$CHOICE" = "false" ] || [ -z "$CHOICE" ]; then
    exit 0
fi

LANG_CODE="it"
if [[ "$CHOICE" == *"English"* ]]; then LANG_CODE="en"; fi
if [[ "$CHOICE" == *"Español"* ]]; then LANG_CODE="es"; fi

mkdir -p "$INSTALL_DIR" "$TMP_DIR"

fetch_with_curl() {
    local fname="$1"
    local dest="$2"
    for src in "$LOCAL_DIST/$fname" "$SCRIPT_DIR/$fname" "$HOME/Downloads/$fname"; do
        if [ -f "$src" ]; then
            echo "[*] Trovato $fname in locale ($src)!"
            cp -f "$src" "$dest" && return 0
        fi
    done
    curl -fSL "$GITHUB_BASE/$fname" -o "$dest"
}

ARCH=$(uname -m)
if [ "$ARCH" = "arm64" ]; then
    PY_ARCHIVE="python_standalone_mac_arm64.tar.gz"
else
    PY_ARCHIVE="python_standalone_mac_x64.tar.gz"
fi

osascript -e 'display notification "1/5 • Download Python 3.12 Portatile Standalone (curl)..." with title "BibleTime AI Scholar Suite"' 2>/dev/null || true
if [ ! -x "$INSTALL_DIR/python_standalone/bin/python3" ]; then
    if fetch_with_curl "$PY_ARCHIVE" "$TMP_DIR/$PY_ARCHIVE"; then
        mkdir -p "$INSTALL_DIR/python_standalone"
        tar -xzf "$TMP_DIR/$PY_ARCHIVE" -C "$INSTALL_DIR/python_standalone" --strip-components=1
    fi
fi

osascript -e 'display notification "2/5 • Download BibleTime_AI_Suite.zip (curl)..." with title "BibleTime AI Scholar Suite"' 2>/dev/null || true
fetch_with_curl "BibleTime_AI_Suite.zip" "$TMP_DIR/BibleTime_AI_Suite.zip"

ZIP_SIZE=$(stat -f%z "$TMP_DIR/BibleTime_AI_Suite.zip" 2>/dev/null || echo 0)
if [ ! -f "$TMP_DIR/BibleTime_AI_Suite.zip" ] || [ "$ZIP_SIZE" -lt 10000000 ]; then
    osascript -e 'display alert "Download Incompleto" message "BibleTime_AI_Suite.zip non è stato scaricato correttamente o è incompleto.\nVerifica la connessione o inserisci il file nella cartella Downloads." as critical' 2>/dev/null || true
    exit 1
fi

osascript -e 'display notification "3/5 • Estrazione Biblioteca Accademica e 518 moduli SWORD..." with title "BibleTime AI Scholar Suite"' 2>/dev/null || true
unzip -qo "$TMP_DIR/BibleTime_AI_Suite.zip" -d "$INSTALL_DIR"
chmod +x "$INSTALL_DIR"/*.command "$INSTALL_DIR"/*.sh 2>/dev/null || true
xattr -dr com.apple.quarantine "$INSTALL_DIR" 2>/dev/null || true

osascript -e 'display notification "4/5 • Generazione ambiente .venv_mac e dipendenze..." with title "BibleTime AI Scholar Suite"' 2>/dev/null || true
PY_BIN="$INSTALL_DIR/python_standalone/bin/python3"
[ ! -x "$PY_BIN" ] && PY_BIN="python3"
"$PY_BIN" -m venv "$INSTALL_DIR/.venv_mac"
"$INSTALL_DIR/.venv_mac/bin/pip" install --upgrade pip -q
"$INSTALL_DIR/.venv_mac/bin/pip" install -r "$INSTALL_DIR/requirements.txt" -q

# 5. Impostazione Lingua Scelta e Collegamento Desktop
for cfg in "$INSTALL_DIR/server/router/config.default.json" "$INSTALL_DIR/server/router/config.json"; do
    if [ -f "$cfg" ]; then
        "$INSTALL_DIR/.venv_mac/bin/python" -c "import json; p='$cfg'; d=json.load(open(p)); d['language']='$LANG_CODE'; json.dump(d, open(p,'w'), indent=2)"
    fi
done

if [ -f "$INSTALL_DIR/dist/index.html" ]; then
    "$INSTALL_DIR/.venv_mac/bin/python" -c "p='$INSTALL_DIR/dist/index.html'; h=open(p).read(); b=\"<script>localStorage.setItem('bibletime_lang','$LANG_CODE');localStorage.setItem('bibletime_app_language','$LANG_CODE');</script>\"; open(p,'w').write(h.replace('<head>','<head>'+b,1)) if 'bibletime_lang' not in h else None"
fi

ln -sf "$INSTALL_DIR/AVVIA_MAC.command" "$HOME/Desktop/BibleTime AI Scholar Suite.command"

osascript -e 'display dialog "✅ Installazione completata con successo!\nProva gratuita di 30 giorni attiva (7 studi/giorno)." buttons {"🚀 Avvia BibleTime Ora"} default button 1 with title "BibleTime AI Scholar Suite"' 2>/dev/null || true
"$INSTALL_DIR/AVVIA_MAC.command" &

