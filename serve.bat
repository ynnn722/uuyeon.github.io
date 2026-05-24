@echo off
setlocal EnableDelayedExpansion
cd /d "%~dp0"

REM Ruby/Jekyll 경로 탐색 (설치 위치가 다를 수 있음)
set "FOUND=0"
for %%D in (
  "%LOCALAPPDATA%\Microsoft\WindowsApps"
  "C:\Ruby40-x64\bin"
  "C:\Ruby34-x64\bin"
  "C:\Ruby33-x64\bin"
  "C:\Ruby32-x64\bin"
) do (
  if exist "%%~D\jekyll.bat" (
    set "PATH=%%~D;!PATH!"
    set "FOUND=1"
    goto :jekyll_check
  )
)

:jekyll_check
where jekyll >nul 2>&1
if errorlevel 1 (
  echo.
  echo [ERROR] jekyll 명령을 찾을 수 없습니다.
  echo   - Ruby 설치 후: gem install jekyll
  echo   - 또는 serve.bat 상단의 Ruby bin 경로를 본인 PC에 맞게 수정하세요.
  echo.
  pause
  exit /b 1
)

echo Cleaning old build...
call jekyll clean
if errorlevel 1 (
  echo [WARN] jekyll clean 실패 — 계속 진행합니다.
)

echo.
echo Starting local server at http://127.0.0.1:4000/
echo Press Ctrl+C to stop.
echo.
call jekyll serve --config _config.yml,_config_development.yml --livereload
if errorlevel 1 (
  echo.
  echo [ERROR] jekyll serve 실패. 위 오류 메시지를 확인하세요.
  pause
  exit /b 1
)
