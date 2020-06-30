﻿# Install Chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Chocolatey Applications
choco install -y `
    python3 `
    filezilla `
    malwarebytes `
    resilio-sync-business `
    keepassxc `
    steam `
    vscode `
    firefox `
    nextcloud-client `
    7zip `
    git `
    vmwareworkstation `
    PDFXchangeEditor `
    autohotkey `
    geforce-experience `
    epicgameslauncher `
    nodejs `
    qbittorrent 

# Configure git
git config --global user.name "Sean Heath"
git config --global user.email "se@nheath.com"

# Remove crappy windows applications and reinstall store
Get-AppxPackage -AllUsers | Remove-AppxPackage
Get-AppXPackage *WindowsStore* -AllUsers | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"} 

# Enable WSL
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
wsl --set-default-version 2

# Show file extensions
Push-Location
Set-Location HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced
Set-ItemProperty . HideFileExt "0"
Pop-Location
Stop-Process -processName: Explorer -force

# Set up hosts file
cd C:\Users\user
mkdir workspace
cd workspace
git clone https://github.com/StevenBlack/hosts hosts
cd hosts
python -m pip install --upgrade pip
python -m pip install --user -r requirements.txt
python updateHostsFile.py -a -r -e social porn gambling fakenews
ipconfig /flushdns

# Move ahk to correct folder
cd C:\Users\user\workspace
git clone https://github.com/seandheath/winconfig winconfig
cd winconfig
cp snap.ahk "C:\Users\user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\snap.ahk"

# Move eisvogel template to the correct folder
mkdir -p "C:\Users\user\AppData\Roaming\pandoc\templates\"
cp eisvogel.tex "C:\Users\user\AppData\Roaming\pandoc\templates\eisvogel.latex"

# install mermaid-filter
npm install --global mermaid-filter

# Add tool folder to path
mkdir "C:\tools"
setx path "%path%;c:\tools"
cp pandoc-crossref.exe "C:\tools\"