New-Item -Type HardLink -Path $PROFILE -Value .\Microsoft.PowerShell_profile.ps1 -Force
New-Item -Type HardLink -Path "~/.config/omp.toml" -Value .\omp.toml -Force
& $PROFILE

Write-Host "done"