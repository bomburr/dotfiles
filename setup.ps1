$userpath = $env:HOMEPATH
## Installing choco
Write-Host  "Choco is installing..." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

## Module installations
Install-Module -Name Terminal-Icons -Repository PSGallery
## software installations
choco install vmware-workstation-player
choco install git  -y
choco install vscode -y
choco install python -y
choco install lightshot.install  -y
choco install spotify  -y
choco install winscp  -y
choco install oh-my-posh -y
choco install everything -y 
choco install microsoft-windows-terminal


## customized templates
Write-host "oh-my-posh Template installing" -ForegroundColor Green
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bomburr/dotfiles/main/robbyrussel.omp.json" -OutFile "c:$userpath\AppData\Local\Programs\oh-my-posh\themes\robbyrussel.omp.json"
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bomburr/dotfiles/main/robbyrussel.omp.json" -OutFile "C:\Program Files\WindowsPowerShell\Modules\oh-my-posh\themes\robbyrussel.omp.json"
Write-host "editing settings.json for vscode" -ForegroundColor Green
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bomburr/dotfiles/main/settings.json" -OutFile "c:$userpath\AppData\Roaming\Code\User\settings.json"

## editing powershell profile 
get-item "c:$userpath\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" | Add-Content -Value '
Import-Module oh-my-posh
Set-PoshPrompt -Theme robbyrussel
Import-Module -Name Terminal-Icons'

## env variables
$envs = @("%USERPROFILE%\AppData\Local\Programs\oh-my-posh\bin")
$envs.GetEnumerator() | % {$Env:Path += ";$($_)"}

## git clones 
if(-not (get-item c:\works)){
if(new-item -Name "works" -Path "C:\" -ItemType Directory){
    new-item -Name "repos" -Path "C:\works" -ItemType Directory
}}

$git_base = "C:\works\repos"

function gitclone($url){
    $name = $url.Split('/')[-1].Replace('.git', '')
    $loc = $git_base+"\"+$name
git clone $url $loc
}


#repos

