@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo [1/3] 本地构建检查...
hugo --gc --minify
if errorlevel 1 (
    echo.
    echo 构建失败，请把上面的报错发我。已中止发布。
    pause
    exit /b 1
)
echo [2/3] 提交改动...
git add -A
git diff-index --quiet HEAD --
if errorlevel 1 (
    git commit -m "post: %date% %time%"
) else (
    echo 没有可提交的改动。
)
echo [3/3] 推送到 GitHub...
git push
if errorlevel 1 (
    echo.
    echo 推送失败，检查网络或 GitHub 登录状态。
    pause
    exit /b 1
)
echo.
echo 完成。GitHub Actions 构建约 1 分钟后生效：
echo https://mariolne.github.io/
pause