@echo off
setlocal
cd /d "%~dp0"

echo [1/3] 本地构建检查...
hugo --gc --minify
if errorlevel 1 goto build_fail

echo [2/3] 提交改动...
git add -A
git diff --cached --quiet
if errorlevel 1 (
    git commit -m "publish %date% %time%"
) else (
    echo 没有新的改动需要提交。
)

echo [3/3] 推送到 GitHub...
git push
if errorlevel 1 goto push_fail

echo.
echo 发布完成。GitHub Actions 约 1 分钟后更新：
echo https://mariolne.github.io/Mario_blog/
goto end

:build_fail
echo.
echo 构建失败：把上面的报错发我，内容没有被推送。
goto end

:push_fail
echo.
echo 推送失败：检查网络或 GitHub 登录状态，内容已提交但没上传。
goto end

:end
echo.
pause