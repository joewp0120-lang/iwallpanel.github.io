@echo off
setlocal ENABLEEXTENSIONS
pushd "%~dp0"
echo Updating GitHub repository...
where git >nul 2>&1 || (
  echo Error: Git is not installed or not in PATH.
  echo Please install Git for Windows.
  exit /b 1
)
set "REPO_URL=https://github.com/joewp0120-lang/iwallpanel.github.io"
set "BRANCH=main"
if not exist ".git" (
  git init
)
for /f "delims=" %%R in ('git config --get user.name 2^>nul') do set "GIT_USER=%%R"
if not defined GIT_USER (
  git config user.name "SJSG decorative material Co., Ltd"
)
for /f "delims=" %%R in ('git config --get user.email 2^>nul') do set "GIT_EMAIL=%%R"
if not defined GIT_EMAIL (
  git config user.email "Joewp0120@gmail.com"
)
for /f "delims=" %%R in ('git remote get-url origin 2^>nul') do set "REMOTE_URL=%%R"
if not defined REMOTE_URL (
  git remote add origin "%REPO_URL%"
) else (
  git remote set-url origin "%REPO_URL%"
)
for /f "delims=" %%B in ('git rev-parse --abbrev-ref HEAD 2^>nul') do set "CUR_BRANCH=%%B"
if not defined CUR_BRANCH (
  git checkout -B "%BRANCH%"
) else (
  if /i not "%CUR_BRANCH%"=="%BRANCH%" (
    git branch "%BRANCH%" 2>nul
    git checkout "%BRANCH%"
  )
)
git add -A
git commit -m "Sync: update via update_github.bat on %DATE% %TIME%" 2>nul
if errorlevel 1 (
  echo No changes to commit or commit failed; continuing.
)
git pull --rebase origin "%BRANCH%" 2>nul
git push -u origin "%BRANCH%"
if errorlevel 1 (
  echo Push failed. Please resolve authentication or conflicts.
  exit /b 1
)
echo Done. GitHub repository updated.
popd
endlocal
