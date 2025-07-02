<#
.SYNOPSIS
    MkDocs 项目构建和部署脚本
.DESCRIPTION
    1. 清理项目目录
    2. 构建 MkDocs 文档
    3. 配置 Git 并提交更改
.NOTES
    需要 PowerShell 5.1 或更高版本
#>

# 提升进程优先级以加速操作
$Process = Get-Process -Id $PID
$Process.PriorityClass = "AboveNormal"

# 获取脚本所在目录
$clear_code_path = $PSScriptRoot
Set-Location $clear_code_path
Write-Host "当前程序执行所在目录为：$($PWD.Path)" -ForegroundColor Cyan

# 读取INI文件函数
function Read-IniFile {
    param(
        [string]$file,
        [string]$section,
        [string]$item
    )
    $option = Get-Content $file |
        Where-Object { $_ -match "$$$section$$" -or ($_ -match "^$item\s*=" -and $null -ne $sectionFound) } |
        ForEach-Object {
            if ($_ -match "$$$section$$") { $sectionFound = $true }
            elseif ($sectionFound -and $_ -match "^$item\s*=") {
                return ($_ -split '=', 2)[1].Trim()
            }
        }
    return $option
}

# 用户确认
$confirm = Read-Host "请确认当前所在目录，是否清理 $($PWD.Path) 下文件，输入 y 继续执行，输入 n 停止执行"
switch ($confirm) {
    'y' { Write-Host "继续执行" -ForegroundColor Green }
    'n' { exit 127 }
    default {
        Write-Host "输入错误，脚本停止" -ForegroundColor Red
        exit 128
    }
}

# 清理文件（排除指定文件/目录）
$excludeItems = @(
    "mkdocs.yml", "README.md", "docs", "site", ".git",
    "clear_code.ps1", "requirements.txt", "build_option.ini",
    "mac_clear_code.sh", ".gitignore", "venv", "mac_sed.sh", "see.sh"
)

Get-ChildItem -Path $clear_code_path -Force |
    Where-Object { $_.Name -notin $excludeItems } |
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# 生成 requirements.txt
pip freeze | Out-File -FilePath "requirements.txt" -Encoding UTF8

# 构建 MkDocs
Write-Host "正在构建 MkDocs..." -ForegroundColor Yellow
mkdocs.exe build --clean --no-strict

# 移动站点文件
if (Test-Path "site") {
    Get-ChildItem -Path "site" -Force | Move-Item -Destination $clear_code_path -Force
    Remove-Item -Path "site" -Recurse -Force
}
Write-Host "web页面生成完成" -ForegroundColor Green

# 读取Git配置
$username = Read-IniFile -file "$clear_code_path\build_option.ini" -section "github" -item "username"
$email = Read-IniFile -file "$clear_code_path\build_option.ini" -section "github" -item "email"
Write-Host "设置当前提交用户名：$username"
Write-Host "设置当前提交邮箱：$email"

# Git配置确认
$git_confirm = Read-Host "请确认设置的用户名和邮箱，输入 y 继续执行，输入 n 停止执行"
switch ($git_confirm) {
    'y' { Write-Host "继续执行" -ForegroundColor Green }
    'n' { exit 127 }
    default {
        Write-Host "输入错误，脚本停止" -ForegroundColor Red
        exit 128
    }
}

# 配置Git
git config credential.helper 'cache --timeout 0'
git config --global credential.helper 'cache --timeout 0'
git config --system credential.helper 'cache --timeout 0'
git config user.name $username
git config user.email $email

# 显示当前配置
Write-Host "当前提交设置："
git config --list

# 提交更改
Write-Host "---------------进行提交----------------" -ForegroundColor Yellow
git add -A
git commit -m "commit_message"
git push -u origin main

# 恢复进程优先级
$Process.PriorityClass = "Normal"
Write-Host "所有操作已完成！" -ForegroundColor Green