if (( Get-ExecutionPolicy ) -ne "RemoteSigned") {
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine -Force
}

if ($IsWindows) {
  New-Item -Type HardLink -Path "$env:APPDATA\rustfmt\rustfmt.toml" -Value .\rustfmt.toml -Force
  New-Item -Type HardLink -Path "$env:LOCALAPPDATA\omp.toml" -Value .\omp.toml -Force
}
elseif ($IsLinux) {
  New-Item -Type HardLink -Path "~/.config/rustfmt/rustfmt.toml" -Value .\rustfmt.toml -Force
  New-Item -Type HardLink -Path "~/.config/omp.toml" -Value .\omp.toml -Force
}

New-Item -Type HardLink -Path $PROFILE -Value .\Microsoft.PowerShell_profile.ps1 -Force
& $PROFILE

Write-Host "done"