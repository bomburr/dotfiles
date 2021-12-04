$userpath = $env:HOMEPATH
Write-Host "Choco is installing..." -ForegroundColor Green
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))


choco install vmware-workstation-player
choco install git  -y
choco install vscode -y
choco install python -y
choco install lightshot.install  -y
choco install spotify  -y
choco install winscp  -y
choco install oh-my-posh -y
choco install everything -y 

Invoke-WebRequest -Uri"https://raw.githubusercontent.com/bomburr/dotfiles/main/night-owl.omp.json" -OutFile "c:$user\Documents\WindowsPowerShell\Modules\oh-my-posh\6.17.0\themes\night-owl.omp.json"

## editing powershell profile
get-item "c:$user\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" | Add-Content -Value 'Import-Module oh-my-posh
Set-PoshPrompt -Theme night-owl'

## env variables
$envs = @("%USERPROFILE%\AppData\Local\Programs\oh-my-posh\bin",
          "%USERPROFILE%\AppData\Local\Programs\oh-my-posh\themes")

$envs.GetEnumerator() | % {$Env:Path += ";$($_)"}


## editing powershell profile
get-item "c:$user\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" | Add-Content -Value 'Import-Module oh-my-posh
Set-PoshPrompt -Theme night-owl'


## git clones 

if(new-item -Name "works" -Path "C:\" -ItemType Directory){
    new-item -Name "repos" -Path "C:\works" -ItemType Directory
}

$git_base = "C:\works\repos"

function gitclone($url){
    $name = $url.Split('/')[-1].Replace('.git', '')
    $loc = $git_base+"\"+$name
git clone $url $loc
}


#repos

