@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo 正在启动本地预览，浏览器稍后自动打开...
start "" http://localhost:1313/
hugo server -D --navigateToChanged
pause