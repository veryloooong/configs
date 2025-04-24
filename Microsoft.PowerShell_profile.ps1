# powershell 7+ only

Import-Module PSReadline
Import-Module posh-git
Import-Module PSFzf

if ($IsWindows) {
  oh-my-posh init pwsh --config "$env:LOCALAPPDATA\omp.toml" | Invoke-Expression
}
elseif ($IsLinux) { 
  oh-my-posh init pwsh --config "~/.config/omp.toml" | Invoke-Expression
}

Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteCharOrExit

Set-PSReadlineOption -PredictionSource History

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
 
if ($IsWindows) {
  Set-Alias vswhere -Value "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

  function Start-VisualStudioEnv {
    $vs = vswhere -prerelease -format json -latest | ConvertFrom-Json
    $installationPath = $vs.installationPath
    Import-Module "$installationPath\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
    Enter-VsDevShell $vs.instanceId -SkipAutomaticLocation
  }

  function Get-FullCmdPath {
    param (
      [string]$name
    )

    Get-Command -Name $name | Select-Object -ExpandProperty Path
  }

  Set-Alias -Name which -Value Get-FullCmdPath
}
