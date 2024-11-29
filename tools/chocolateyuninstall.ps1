# Get ProductCode (GUID) of Oracle JDK 21
$jdkProductCode = (Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "Java SE Development Kit 21*" }).IdentifyingNumber

if ($jdkProductCode) {
    # Uninstall JDK
    Write-Host "Uninstalling Oracle JDK 21..."
    Start-Process -FilePath "msiexec.exe" -ArgumentList "/x $jdkProductCode /quiet /norestart" -Wait
    Write-Host "Oracle JDK 21 uninstalled successfully."
} else {
    Write-Warning "Oracle JDK 21 not found. Skipping uninstallation."
}

# Remove JAVA_HOME environment variable
Write-Host "Removing JAVA_HOME environment variable..."
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $null, [System.EnvironmentVariableTarget]::Machine)

# Remove JAVA_HOME\bin from PATH
Write-Host "Updating PATH environment variable to remove JAVA_HOME\bin..."
$path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
if ($path -match ";C:\\Program Files\\Java\\jdk-21\\bin") {
    $newPath = $path -replace ";C:\\Program Files\\Java\\jdk-21\\bin", ""
    [System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)
    Write-Host "PATH environment variable updated."
} else {
    Write-Warning "JAVA_HOME\bin not found in PATH. Skipping update."
}

Write-Host "Uninstallation script completed."
