@echo off
setlocal
cd /d "%~dp0"
echo 正在启动本地预览（草稿也能看到）...
echo 浏览器会自动打开 http://localhost:1313/
echo 关掉这个黑窗口就停止预览。
start "" http://localhost:1313/
hugo server -D --navigateToChanged
pause