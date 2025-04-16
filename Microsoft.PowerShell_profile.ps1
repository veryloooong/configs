Import-Module PSReadline
Import-Module posh-git

oh-my-posh init pwsh --config "C:\Users\Long\.config\omp.toml" | Invoke-Expression

Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })
Invoke-Expression (& { (cargo-shuttle generate shell powershell | Out-String) })

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'

function Start-VisualStudioEnv {
  Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
  Enter-VsDevShell bff8c5b6 -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64"
}

function Start-AdminShell {
  Start-Process wt.exe -Verb RunAs
}

function Get-FullCmdPath {
  param (
    [string]$name
  )

  Get-Command -Name $name | Select-Object -ExpandProperty Path
}

Set-Alias -Name which -Value Get-FullCmdPath
