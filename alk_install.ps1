if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))  
{  
  $arguments = "& '" +$myinvocation.mycommand.definition + "'"
  Start-Process powershell -Verb runAs -ArgumentList $arguments
  Break
}

Write-Host "Downloading ALK"

$url = "https://github.com/alk-language/java-semantics/releases/download/3.0/alk-v3.0.zip"
$output = "~/Downloads/alk.zip"
$start_time = Get-Date

Invoke-WebRequest -Uri $url -OutFile $output
Write-Output "Time taken: $((Get-Date).Subtract($start_time).Seconds) second(s)"

Expand-Archive "~/Downloads/alk.zip" "C:/Alk"

setx /M PATH "$ENV:Path;C:\Alk\v3.0\bin"