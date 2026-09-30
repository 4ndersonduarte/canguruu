$ErrorActionPreference = 'Stop'
$appDirectory = Split-Path -Parent $PSScriptRoot
Push-Location -LiteralPath $appDirectory
try {
    dart compile js -O2 --no-source-maps tool/drift_worker.dart -o web/drift_worker.dart.js
    if ($LASTEXITCODE -ne 0) { throw 'Falha ao compilar o worker SQLite.' }
    # Compiler metadata may contain local paths and must not enter the Web bundle.
    foreach ($relative in @('web\drift_worker.dart.js.deps', 'web\drift_worker.dart.js.map')) {
        $metadataPath = Join-Path $appDirectory $relative
        if (Test-Path -LiteralPath $metadataPath) { Remove-Item -LiteralPath $metadataPath }
    }
    flutter build web --release --no-web-resources-cdn --pwa-strategy=offline-first --no-wasm-dry-run
    if ($LASTEXITCODE -ne 0) { throw 'Falha ao compilar a versão Web.' }
} finally {
    Pop-Location
}
