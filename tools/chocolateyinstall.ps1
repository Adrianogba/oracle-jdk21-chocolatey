#Write-Host "This installation is subject to the Oracle Technology Network License Agreement for Oracle Java SE."
#Write-Host "Permitted uses include personal and development use at no cost."
#Write-Host "Other uses may require a commercial license."
#Write-Host "Review the terms at: https://www.oracle.com/downloads/licenses/java-se-license.html"
#Write-Host "By continuing, you agree to these terms."

$packageArgs = @{
  PackageName = $env:ChocolateyPackageName
  Url64bit = 'https://download.oracle.com/java/21/archive/jdk-21.0.4_windows-x64_bin.msi'
  Checksum64 = 'fa4e050a8535a581560ba19bd933caeb56730b5c3936180f3eb36cf0d69286af'
  ChecksumType64 = 'sha256'
  fileType      = 'msi'
  silentArgs    = "INSTALLLEVEL=3 /quiet"
}

Install-ChocolateyPackage @packageArgs

# Set JAVA_HOME
$jdkInstallPath = "C:\Program Files\Java\jdk-21"
[System.Environment]::SetEnvironmentVariable("JAVA_HOME", $jdkInstallPath, [System.EnvironmentVariableTarget]::Machine)

# Update PATH
$path = [System.Environment]::GetEnvironmentVariable("Path", [System.EnvironmentVariableTarget]::Machine)
$newPath = "$path;$($jdkInstallPath)\bin"
[System.Environment]::SetEnvironmentVariable("Path", $newPath, [System.EnvironmentVariableTarget]::Machine)

Write-Host "JAVA_HOME set to $jdkInstallPath and added to PATH."