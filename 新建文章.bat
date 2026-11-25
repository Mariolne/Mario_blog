@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo ================================================
echo  新建一篇文章（默认是题解模板）
echo  文件名只能用英文/数字/短横线，例如：
echo    lc-70-climbing-stairs
echo    cf-1800-some-problem
echo ================================================
set /p name=请输入文件名（不要带 .md）:
if "%name%"=="" goto :end
hugo new content "posts/%name%.md" --kind posts
if errorlevel 1 goto :end
notepad "content\posts\%name%.md"
echo.
echo 写完保存后，双击「发布.bat」即可上线。
:end
pause