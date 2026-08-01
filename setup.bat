@echo off
chcp 65001 >nul
title 博客部署脚本 - huaoyan.top
echo ╔══════════════════════════════════════════╗
echo ║  🌐 Huaoyan Blog 一键部署脚本           ║
echo ╚══════════════════════════════════════════╝
echo.

:: ============================================================
:: Step 1: Push code to GitHub
:: ============================================================
echo [1/4] 推送代码到 GitHub...
echo.

cd /d "D:\Zcode Program(myself)\huaoyan-blog-2026"

:: Check if remote exists
git remote get-url origin >nul 2>&1
if %errorlevel% neq 0 (
    echo 添加远程仓库...
    git remote add origin https://github.com/aoyanhu/huaoyan-blog-2026.git
)

echo 正在推送代码（可能需要输入 GitHub 用户名和密码）...
git push -u origin main
if %errorlevel% neq 0 (
    echo.
    echo ❌ 推送失败！请检查：
    echo    1. 是否已登录 GitHub
    echo    2. 仓库 https://github.com/aoyanhu/huaoyan-blog-2026 是否存在
    echo    3. 网络是否正常
    echo.
    echo 如果使用 Token 认证，请运行：
    echo    git remote set-url origin https://TOKEN@github.com/aoyanhu/huaoyan-blog-2026.git
    echo   （将 TOKEN 替换为你的 GitHub Personal Access Token）
    pause
    exit /b 1
)
echo ✅ 代码推送成功！
echo.

:: ============================================================
:: Step 2: Get Giscus IDs
:: ============================================================
echo [2/4] 配置 Giscus 评论区...
echo.
echo 请按照以下步骤手动操作：
echo.
echo   1. 打开浏览器访问：
echo      https://github.com/aoyanhu/huaoyan-blog-2026/settings
echo      勾选 ☑ Discussions 功能
echo.
echo   2. 访问 https://github.com/apps/giscus
echo      点击 Install → 选择 Only select repositories
echo      选择 aoyanhu/huaoyan-blog-2026 → Install
echo.
echo   3. 访问 https://giscus.app
echo      填入 aoyanhu/huaoyan-blog-2026
echo      复制 data-repo-id 的值（格式如 R_kgDOxxx）
echo      复制 data-category-id 的值（格式如 DIC_kwDOxxx）
echo.
set /p REPO_ID="请输入 data-repo-id: "
set /p CATEGORY_ID="请输入 data-category-id: "

:: Update comments.html
powershell -Command "(Get-Content 'D:\Zcode Program(myself)\huaoyan-blog-2026\layouts\partials\comments.html') -replace 'R_kgDOOSda1Q', '%REPO_ID%' -replace 'DIC_kwDOOSda1c4Co5Gt', '%CATEGORY_ID%' | Set-Content 'D:\Zcode Program(myself)\huaoyan-blog-2026\layouts\partials\comments.html'"

git add layouts/partials/comments.html
git commit -m "chore: update Giscus repo-id and category-id"
git push origin main
echo ✅ Giscus 配置完成！
echo.

:: ============================================================
:: Step 3: Enable GitHub Pages
:: ============================================================
echo [3/4] 启用 GitHub Pages...
echo.
echo 请手动操作：
echo   1. 打开 https://github.com/aoyanhu/huaoyan-blog-2026/settings/pages
echo   2. Build and deployment → Source 选择 GitHub Actions
echo   3. 保存
echo.
echo   如果看到 "Your site is live at..." 说明部署成功！
echo.
echo   第一次部署需要等待 1-2 分钟。
echo   可以先访问 https://aoyanhu.github.io/huaoyan-blog-2026/ 查看效果。
echo.
pause
echo.

:: ============================================================
:: Step 4: DNS Configuration
:: ============================================================
echo [4/4] 配置域名 DNS...
echo.
echo 请登录购买 huaoyan.top 的域名服务商，添加以下 DNS 记录：
echo.
echo ┌────────┬──────────┬──────────────────────────┐
echo │ 类型   │ 主机记录 │ 记录值                    │
echo ├────────┼──────────┼──────────────────────────┤
echo │ CNAME  │ www      │ aoyanhu.github.io        │
echo │ A      │ @        │ 185.199.108.153          │
echo │ A      │ @        │ 185.199.109.153          │
echo │ A      │ @        │ 185.199.110.153          │
echo │ A      │ @        │ 185.199.111.153          │
echo └────────┴──────────┴──────────────────────────┘
echo.
echo 添加完成后，在 GitHub 仓库 Settings → Pages 中：
echo   Custom domain 填入 huaoyan.top → Save
echo   勾选 Enforce HTTPS
echo.
echo DNS 生效需要等待几分钟到几小时不等。
echo.

:: ============================================================
:: Done!
:: ============================================================
echo ╔══════════════════════════════════════════╗
echo ║  🎉 全部配置完成！                      ║
echo ║                                          ║
echo ║  博客地址: https://huaoyan.top           ║
echo ║  备用地址: https://aoyanhu.github.io     ║
echo ║                /huaoyan-blog-2026        ║
echo ╚══════════════════════════════════════════╝
echo.
echo 以后写文章只需要三步：
echo   1. hugo new posts/2026/XX-XX-标题/index.md
echo   2. 编辑文章（改 draft: false）
echo   3. git add -A ^&^& git commit -m "新文章" ^&^& git push
echo.
pause
