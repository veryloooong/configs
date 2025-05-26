# Removes all the files and directories created by the setup script
$ErrorActionPreference = "SilentlyContinue"

if ($IsWindows) {
  Remove-Item -Path "$env:APPDATA\rustfmt\rustfmt.toml" -Force -ErrorAction $ErrorActionPreference
  Remove-Item -Path "$env:LOCALAPPDATA\omp.toml" -Force -ErrorAction $ErrorActionPreference
  Remove-Item -Path "$env:APPDATA\helix\" -Recurse -Force -ErrorAction $ErrorActionPreference
}
elseif ($IsLinux) {
  Remove-Item -Path "~/.config/rustfmt/rustfmt.toml" -Force -ErrorAction $ErrorActionPreference
  Remove-Item -Path "~/.config/omp.toml" -Force -ErrorAction $ErrorActionPreference
  Remove-Item -Path "~/.config/helix/" -Recurse -Force -ErrorAction $ErrorActionPreference
}

Remove-Item -Path $PROFILE -Force -ErrorAction $ErrorActionPreference

Write-Host "done unsetup"