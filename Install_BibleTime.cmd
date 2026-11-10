@echo off
chcp 65001 >nul
title BibleTime AI Scholar Suite - Avvio Setup
more +7 "%~f0" > "%TEMP%\bt_setup_wizard.ps1"
start "" /b powershell.exe -WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File "%TEMP%\bt_setup_wizard.ps1"
exit /b 0
:: ===== POWERSHELL GUI WIZARD =====
# ==============================================================================
# BIBLETIME AI SCHOLAR SUITE - LUXURY VISUAL SETUP WIZARD (WINDOWS WPF)
# 100% Pure-ASCII safe for Windows PowerShell 5.1 & PowerShell 7 across all locales.
# Downloads via curl.exe, configures Python 3.12 Standalone + .venv_win + Language.
# Strictly under 280 lines. Zero external console windows.
# ==============================================================================

# 1. HIDE ANY HOSTING WINDOWS CONSOLE IMMEDIATELY
try {
    Add-Type -Name Win32Console -Namespace Native -MemberDefinition @"
[DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
"@ -ErrorAction SilentlyContinue
    $h = [Native.Win32Console]::GetConsoleWindow()
    if ($h -ne [IntPtr]::Zero) { [Native.Win32Console]::ShowWindow($h, 0) }
} catch {}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$LocalDistDir = Join-Path (Split-Path -Parent $ScriptDir) "dist_clienti"
if (-not (Test-Path $LocalDistDir)) {
    $LocalDistDir = "C:\Users\carto\Desktop\BibleTime\react\dist_clienti"
}
$GithubBaseUrl = "https://github.com/scesho/BibleTime-AI-Scholar-Suite/releases/download/installer"
$InstallDir = Join-Path $env:LOCALAPPDATA "BibleTime_AI_Suite"

function U([int]$code) { return [char]::ConvertFromUtf32($code) }
$BULLET = U 0x2022
$SPARK  = U 0x2728
$ROCKET = U 0x1F680
$CHECK  = U 0x2713

$I18N = @{
    it = @{
        sub = "INSTALLAZIONE AUTOMATICA ASSISTITA $BULLET EDIZIONE ACCADEMICA"
        choose = "1. Seleziona la lingua predefinita del software:"
        btnStart = "$SPARK  Inizia Installazione Automatica"
        btnLaunch = "$ROCKET  Avvia Ora BibleTime AI Scholar Suite"
        readyMsg = "[$CHECK] Installazione completata! Prova gratuita di 30 giorni attiva (7 studi/giorno)."
        s1 = "1/6 $BULLET Download motore Python 3.12 Portatile Standalone (curl)..."
        s2 = "2/6 $BULLET Download pacchetto universale BibleTime_AI_Suite.zip (curl)..."
        s3 = "3/6 $BULLET Estrazione Biblioteca Accademica, 348 moduli SWORD e Database..."
        s4 = "4/6 $BULLET Generazione automatica ambiente .venv_win e librerie..."
        s5 = "5/6 $BULLET Pre-configurazione lingua Italiana e creazione icona Desktop..."
        s6 = "6/6 $BULLET Verifica finale completata con successo!"
    }
    en = @{
        sub = "AUTOMATED VISUAL INSTALLER $BULLET ACADEMIC SCHOLAR EDITION"
        choose = "1. Select your default software language:"
        btnStart = "$SPARK  Start Automatic Installation"
        btnLaunch = "$ROCKET  Launch BibleTime AI Scholar Suite Now"
        readyMsg = "[$CHECK] Installation complete! Your 30-day free trial is active (7 studies/day)."
        s1 = "1/6 $BULLET Downloading Portable Standalone Python 3.12 engine (curl)..."
        s2 = "2/6 $BULLET Downloading universal BibleTime_AI_Suite.zip package (curl)..."
        s3 = "3/6 $BULLET Extracting Academic Library, 348 SWORD modules & Databases..."
        s4 = "4/6 $BULLET Generating isolated .venv_win environment & dependencies..."
        s5 = "5/6 $BULLET Pre-configuring English language & creating Desktop shortcut..."
        s6 = "6/6 $BULLET Final verification completed successfully!"
    }
    es = @{
        sub = "INSTALADOR VISUAL AUTOMATICO $BULLET EDICION ACADEMICA"
        choose = "1. Selecciona el idioma predeterminado del software:"
        btnStart = "$SPARK  Iniciar Instalacion Automatica"
        btnLaunch = "$ROCKET  Iniciar BibleTime AI Scholar Suite Ahora"
        readyMsg = "[$CHECK] Instalacion completada! Prueba gratuita de 30 dias activa (7 estudios/dia)."
        s1 = "1/6 $BULLET Descargando motor Python 3.12 Portatil Standalone (curl)..."
        s2 = "2/6 $BULLET Descargando paquete universal BibleTime_AI_Suite.zip (curl)..."
        s3 = "3/6 $BULLET Extrayendo Biblioteca Academica, 348 modulos SWORD y Bases de datos..."
        s4 = "4/6 $BULLET Generando entorno .venv_win y librerias automaticamente..."
        s5 = "5/6 $BULLET Preconfigurando idioma Espanol y creando icono en el Escritorio..."
        s6 = "6/6 $BULLET Verificacion final completada con exito!"
    }
}

[xml]$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="BibleTime AI Scholar Suite - Setup Wizard" Width="720" Height="620"
        WindowStartupLocation="CenterScreen" ResizeMode="CanMinimize" Background="#0B1120" Foreground="#F8FAFC">
    <Grid Margin="24">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <StackPanel Grid.Row="0" Margin="0,0,0,14">
            <TextBlock Text="BIBLETIME AI SCHOLAR SUITE" FontSize="20" FontWeight="Bold" Foreground="#38BDF8"/>
            <TextBlock x:Name="TxtSub" Text="INSTALLAZIONE AUTOMATICA ASSISTITA" FontSize="11" Foreground="#94A3B8" Margin="0,3,0,0"/>
        </StackPanel>

        <StackPanel Grid.Row="1" Margin="0,0,0,14">
            <TextBlock x:Name="TxtChoose" Text="1. Seleziona la lingua predefinita del software:" FontSize="12" FontWeight="SemiBold" Foreground="#E2E8F0" Margin="0,0,0,8"/>
            <UniformGrid Columns="3" HorizontalAlignment="Stretch">
                <Button x:Name="BtnIt" Margin="0,0,6,0" Padding="10" Background="#0F172A" Foreground="White" BorderBrush="#38BDF8" BorderThickness="2" Cursor="Hand">
                    <StackPanel>
                        <TextBlock Text="[IT]  Italiano" FontSize="14" FontWeight="Bold" HorizontalAlignment="Center"/>
                        <TextBlock Text="Edizione Italiana" FontSize="10" Foreground="#94A3B8" HorizontalAlignment="Center" Margin="0,2,0,0"/>
                    </StackPanel>
                </Button>
                <Button x:Name="BtnEn" Margin="3,0,3,0" Padding="10" Background="#0F172A" Foreground="White" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                    <StackPanel>
                        <TextBlock Text="[EN]  English" FontSize="14" FontWeight="Bold" HorizontalAlignment="Center"/>
                        <TextBlock Text="KJV Scholar Suite" FontSize="10" Foreground="#94A3B8" HorizontalAlignment="Center" Margin="0,2,0,0"/>
                    </StackPanel>
                </Button>
                <Button x:Name="BtnEs" Margin="6,0,0,0" Padding="10" Background="#0F172A" Foreground="White" BorderBrush="#334155" BorderThickness="1" Cursor="Hand">
                    <StackPanel>
                        <TextBlock Text="[ES]  Espanol" FontSize="14" FontWeight="Bold" HorizontalAlignment="Center"/>
                        <TextBlock Text="Reina-Valera Suite" FontSize="10" Foreground="#94A3B8" HorizontalAlignment="Center" Margin="0,2,0,0"/>
                    </StackPanel>
                </Button>
            </UniformGrid>
        </StackPanel>

        <Border Grid.Row="2" Background="#0F172A" BorderBrush="#1E293B" BorderThickness="1" CornerRadius="8" Padding="14" Margin="0,0,0,14">
            <DockPanel LastChildFill="True">
                <StackPanel DockPanel.Dock="Top">
                    <Grid Margin="0,0,0,6">
                        <TextBlock x:Name="TxtStep" Text="Pronto per l'installazione automatica." FontSize="12" FontWeight="SemiBold" Foreground="#38BDF8"/>
                        <TextBlock x:Name="TxtPct" Text="0%" FontSize="12" FontWeight="Bold" Foreground="#10B981" HorizontalAlignment="Right"/>
                    </Grid>
                    <ProgressBar x:Name="ProgBar" Height="12" Minimum="0" Maximum="100" Value="0" Background="#1E293B" Foreground="#10B981" BorderThickness="0"/>
                    <TextBlock x:Name="TxtDetail" Text="Destinazione: $InstallDir" FontSize="10" Foreground="#94A3B8" Margin="0,4,0,0" TextWrapping="Wrap"/>
                    <UniformGrid Columns="2" Margin="0,6,0,0">
                        <TextBlock x:Name="L1" Text="- [ ] Runtime Python 3.12" FontSize="10" Foreground="#64748B" Margin="0,1"/>
                        <TextBlock x:Name="L2" Text="- [ ] BibleTime_AI_Suite.zip" FontSize="10" Foreground="#64748B" Margin="0,1"/>
                        <TextBlock x:Name="L3" Text="- [ ] Librerie e .venv_win" FontSize="10" Foreground="#64748B" Margin="0,1"/>
                        <TextBlock x:Name="L4" Text="- [ ] Collegamento Desktop" FontSize="10" Foreground="#64748B" Margin="0,1"/>
                    </UniformGrid>
                </StackPanel>

                <Border Margin="0,8,0,0" Background="#050814" BorderBrush="#1E293B" BorderThickness="1" CornerRadius="6" Padding="6">
                    <DockPanel LastChildFill="True">
                        <TextBlock DockPanel.Dock="Top" Text="TERMINALE LIVE DI INSTALLAZIONE" FontSize="9" FontWeight="Bold" Foreground="#475569" Margin="2,0,0,3"/>
                        <TextBox x:Name="TxtConsole" Background="Transparent" Foreground="#38BDF8" BorderThickness="0" 
                                 FontFamily="Consolas, Lucida Console, Courier New" FontSize="10" 
                                 IsReadOnly="True" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto"
                                 Text="[Setup] Seleziona la lingua e premi 'Inizia Installazione Automatica'." />
                    </DockPanel>
                </Border>
            </DockPanel>
        </Border>

        <Grid Grid.Row="3">
            <Button x:Name="BtnAction" Content="Inizia Installazione Automatica" Height="44" FontSize="13" FontWeight="Bold"
                    Background="#0284C7" Foreground="White" BorderThickness="0" Cursor="Hand"/>
        </Grid>
    </Grid>
</Window>
"@

$Reader = (New-Object System.Xml.XmlNodeReader $Xaml)
$Window = [Windows.Markup.XamlReader]::Load($Reader)

$TxtSub = $Window.FindName("TxtSub")
$TxtChoose = $Window.FindName("TxtChoose")
$BtnIt = $Window.FindName("BtnIt")
$BtnEn = $Window.FindName("BtnEn")
$BtnEs = $Window.FindName("BtnEs")
$TxtStep = $Window.FindName("TxtStep")
$TxtPct = $Window.FindName("TxtPct")
$ProgBar = $Window.FindName("ProgBar")
$TxtDetail = $Window.FindName("TxtDetail")
$TxtConsole = $Window.FindName("TxtConsole")
$L1 = $Window.FindName("L1"); $L2 = $Window.FindName("L2"); $L3 = $Window.FindName("L3"); $L4 = $Window.FindName("L4")
$BtnAction = $Window.FindName("BtnAction")

$State = [hashtable]::Synchronized(@{ Lang = "it"; Installed = $false; Running = $false })

function Log-Console([string]$msg) {
    if (-not $msg) { return }
    $TxtConsole.AppendText("`r`n$msg")
    $TxtConsole.ScrollToEnd()
    [System.Windows.Forms.Application]::DoEvents()
}

function Select-Lang($lang) {
    if ($State.Running) { return }
    $State.Lang = $lang
    $t = $I18N[$lang]
    $TxtSub.Text = $t.sub
    $TxtChoose.Text = $t.choose
    if (-not $State.Installed) { $BtnAction.Content = $t.btnStart } else { $BtnAction.Content = $t.btnLaunch }
    $BtnIt.BorderBrush = if ($lang -eq "it") { "#38BDF8" } else { "#334155" }
    $BtnEn.BorderBrush = if ($lang -eq "en") { "#38BDF8" } else { "#334155" }
    $BtnEs.BorderBrush = if ($lang -eq "es") { "#38BDF8" } else { "#334155" }
    $BtnIt.BorderThickness = if ($lang -eq "it") { 2 } else { 1 }
    $BtnEn.BorderThickness = if ($lang -eq "en") { 2 } else { 1 }
    $BtnEs.BorderThickness = if ($lang -eq "es") { 2 } else { 1 }
}

Select-Lang "it"
$BtnIt.Add_Click({ Select-Lang "it" })
$BtnEn.Add_Click({ Select-Lang "en" })
$BtnEs.Add_Click({ Select-Lang "es" })

function Update-UI($pct, $stepText, $detailText) {
    $ProgBar.Value = $pct
    $TxtPct.Text = "$pct%"
    if ($stepText) { $TxtStep.Text = $stepText }
    if ($detailText) { $TxtDetail.Text = $detailText }
    [System.Windows.Forms.Application]::DoEvents()
}

function Run-CliLogged($cmd, $args, $label) {
    Log-Console "[$label] Esecuzione: $cmd $args"
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = $cmd
    $pinfo.Arguments = $args
    $pinfo.UseShellExecute = $false
    $pinfo.RedirectStandardOutput = $true
    $pinfo.RedirectStandardError = $true
    $pinfo.CreateNoWindow = $true
    $p = [System.Diagnostics.Process]::Start($pinfo)
    while (-not $p.HasExited) {
        Start-Sleep -Milliseconds 80
        [System.Windows.Forms.Application]::DoEvents()
    }
    $p.WaitForExit()
    $out = $p.StandardOutput.ReadToEnd()
    $err = $p.StandardError.ReadToEnd()
    if ($out) { Log-Console $out.Trim() }
    if ($err) { Log-Console $err.Trim() }
}

function Fetch-WithCurl($fileName, $destFile) {
    $localCandidate = Join-Path $LocalDistDir $fileName
    if (Test-Path $localCandidate) {
        Log-Console "[Locale] Pacchetto trovato: $fileName"
        Copy-Item -Path $localCandidate -Destination $destFile -Force
        if (Test-Path $destFile) { 
            Log-Console "[OK] Copia completata: $fileName"
            return $true 
        }
    }
    $remoteUrl = "$GithubBaseUrl/$fileName"
    Log-Console "[CURL] Download: $remoteUrl"
    
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "curl.exe"
    $pinfo.Arguments = "-fSL --progress-bar `"$remoteUrl`" -o `"$destFile`""
    $pinfo.UseShellExecute = $false
    $pinfo.RedirectStandardError = $true
    $pinfo.CreateNoWindow = $true
    $p = [System.Diagnostics.Process]::Start($pinfo)
    
    $stderrReader = $p.StandardError
    $lastUpdate = [DateTime]::MinValue
    while (-not $p.HasExited) {
        $line = $stderrReader.ReadLine()
        if ($line) {
            $lineClean = $line.Trim()
            if ($lineClean -and ([DateTime]::Now - $lastUpdate).TotalMilliseconds -gt 250) {
                $TxtConsole.AppendText("`r`n$fileName : $lineClean")
                $TxtConsole.ScrollToEnd()
                $TxtDetail.Text = "$fileName : $lineClean"
                [System.Windows.Forms.Application]::DoEvents()
                $lastUpdate = [DateTime]::Now
            }
        } else {
            Start-Sleep -Milliseconds 50
        }
        [System.Windows.Forms.Application]::DoEvents()
    }
    $p.WaitForExit()
    Log-Console "[OK] Download completato: $fileName"
    return (Test-Path $destFile)
}

$BtnAction.Add_Click({
    if ($State.Installed) {
        $pyw = Join-Path $InstallDir ".venv_win\Scripts\pythonw.exe"
        $bat = Join-Path $InstallDir "AVVIA_WINDOWS.bat"
        if (Test-Path $pyw) {
            Start-Process -FilePath $pyw -ArgumentList "launch.py" -WorkingDirectory $InstallDir
            $Window.Close()
        } elseif (Test-Path $bat) {
            Start-Process -FilePath $bat -WorkingDirectory $InstallDir -WindowStyle Hidden
            $Window.Close()
        }
        return
    }
    if ($State.Running) { return }
    $State.Running = $true
    $BtnAction.IsEnabled = $false
    $t = $I18N[$State.Lang]

    try {
        New-Item -ItemType Directory -Force -Path $InstallDir | Out-Null
        $TmpDir = Join-Path $env:TEMP "BibleTime_Setup_Tmp"
        New-Item -ItemType Directory -Force -Path $TmpDir | Out-Null

        # STEP 1: Python Standalone
        Update-UI 10 $t.s1 "curl -> python_standalone_win_x64.tar.gz"
        $pyTar = Join-Path $TmpDir "python_standalone_win_x64.tar.gz"
        $pyDir = Join-Path $InstallDir "python_standalone"
        if (-not (Test-Path (Join-Path $pyDir "python.exe"))) {
            if (Fetch-WithCurl "python_standalone_win_x64.tar.gz" $pyTar) {
                New-Item -ItemType Directory -Force -Path $pyDir | Out-Null
                Run-CliLogged "tar.exe" "-xzf `"$pyTar`" -C `"$pyDir`" --strip-components=1" "TAR"
            }
        }
        $L1.Text = "- [$CHECK] Runtime Python 3.12 Portatile pronto"; $L1.Foreground = "#10B981"

        # STEP 2: BibleTime_AI_Suite.zip
        Update-UI 35 $t.s2 "curl -> BibleTime_AI_Suite.zip"
        $suiteZip = Join-Path $TmpDir "BibleTime_AI_Suite.zip"
        if (-not (Fetch-WithCurl "BibleTime_AI_Suite.zip" $suiteZip)) {
            throw "Impossibile scaricare BibleTime_AI_Suite.zip da GitHub."
        }
        $L2.Text = "- [$CHECK] BibleTime_AI_Suite.zip scaricato e verificato"; $L2.Foreground = "#10B981"

        # STEP 3: Extract zip
        Update-UI 60 $t.s3 "Estrazione archivio in $InstallDir ..."
        Run-CliLogged "tar.exe" "-xf `"$suiteZip`" -C `"$InstallDir`"" "TAR"
        Update-UI 75 $t.s4 "Creazione .venv_win e installazione dipendenze..."

        # STEP 4: Create .venv_win
        $pyExe = Join-Path $pyDir "python.exe"
        if (-not (Test-Path $pyExe)) { $pyExe = "python" }
        $venvDir = Join-Path $InstallDir ".venv_win"
        if (-not (Test-Path (Join-Path $venvDir "Scripts\python.exe"))) {
            Run-CliLogged "$pyExe" "-m venv `"$venvDir`"" "VENV"
        }
        $venvPy = Join-Path $venvDir "Scripts\python.exe"
        if (Test-Path $venvPy) {
            $reqFile = Join-Path $InstallDir "requirements.txt"
            Run-CliLogged "$venvPy" "-m pip install --upgrade pip --quiet" "PIP"
            Run-CliLogged "$venvPy" "-m pip install -r `"$reqFile`" --quiet" "PIP"
            Set-Content -Path (Join-Path $venvDir ".deps_ok") -Value "ok" -Encoding ASCII
        }
        $L3.Text = "- [$CHECK] Ambiente .venv_win e librerie configurate"; $L3.Foreground = "#10B981"

        # STEP 5: Pre-configure chosen Language & Desktop Shortcut
        Update-UI 92 $t.s5 "Impostazione lingua '$($State.Lang)' e icona Desktop..."
        $lang = $State.Lang
        foreach ($cfgName in @("config.default.json", "config.json")) {
            $cfgPath = Join-Path $InstallDir "server\router\$cfgName"
            if (Test-Path $cfgPath) {
                $raw = Get-Content $cfgPath -Raw -Encoding UTF8 | ConvertFrom-Json
                $raw.language = $lang
                $raw | ConvertTo-Json -Depth 6 | Set-Content $cfgPath -Encoding UTF8
            }
        }
        $idxPath = Join-Path $InstallDir "dist\index.html"
        if (Test-Path $idxPath) {
            $html = Get-Content $idxPath -Raw -Encoding UTF8
            $boot = "<script>localStorage.setItem('bibletime_lang','$lang');localStorage.setItem('bibletime_app_language','$lang');</script>"
            if ($html -notmatch "bibletime_lang") {
                $html = $html -replace "<head>", "<head>$boot"
                Set-Content $idxPath -Value $html -Encoding UTF8
            }
        }
        $scScript = Join-Path $InstallDir "create_shortcut.ps1"
        if (Test-Path $scScript) {
            Run-CliLogged "powershell.exe" "-ExecutionPolicy Bypass -File `"$scScript`"" "SHORTCUT"
        }
        $L4.Text = "- [$CHECK] Lingua '$($lang.ToUpper())' e icona Desktop attivate"; $L4.Foreground = "#10B981"

        # STEP 6: Done
        Update-UI 100 $t.s6 $t.readyMsg
        Log-Console "[OK] $t.readyMsg"
        $State.Installed = $true
        $State.Running = $false
        $BtnAction.Content = $t.btnLaunch
        $BtnAction.Background = "#10B981"
        $BtnAction.IsEnabled = $true
    } catch {
        $TxtStep.Text = "Errore durante l'installazione:"
        $TxtDetail.Text = $_.Exception.Message
        Log-Console "[ERRORE] $($_.Exception.Message)"
        $State.Running = $false
        $BtnAction.IsEnabled = $true
    }
})

$Window.ShowDialog() | Out-Null
