@echo off
setlocal
cd /d "%~dp0"
echo ================================================
echo  新建一篇文章（题解模板）
echo  文件名只能用英文、数字、短横线，例如：
echo    lc-70-climbing-stairs
echo ================================================
set /p name=请输入文件名（不要带 .md）:
if "%name%"=="" goto end
hugo new content "posts/%name%.md" --kind posts
if errorlevel 1 goto end
notepad "content\posts\%name%.md"
echo.
echo 写完保存后，把文件里的 draft 改成 false，
echo 再双击「发布.bat」才会出现在线上。
:end
pause