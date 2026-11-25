# 发布前自动剔除 md 文件尾部平台追加的“> AI生成”标识行
# 发布.bat 在构建前调用本脚本
$roots = @('content', 'archetypes')
Set-Location -LiteralPath $PSScriptRoot
foreach ($root in $roots) {
    Get-ChildItem -Path $root -Recurse -Filter *.md -ErrorAction SilentlyContinue | ForEach-Object {
        $p = $_.FullName
        $c = [System.IO.File]::ReadAllText($p)
        if ($c -match '>AI生成|>\s*AI生成') {
            $c2 = [regex]::Replace($c, "(\r?\n)*>\s*AI生成\s*(\r?\n)*\s*$", "`n")
            [System.IO.File]::WriteAllText($p, $c2, (New-Object System.Text.UTF8Encoding($false)))
        }
    }
}