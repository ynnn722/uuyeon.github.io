@echo off
set PATH=C:\Ruby40-x64\bin;%PATH%
cd /d "%~dp0"
echo Cleaning old build...
call jekyll clean
echo.
echo Starting local server at http://127.0.0.1:4000/
echo Press Ctrl+C to stop.
echo.
jekyll serve --config _config.yml,_config_development.yml --livereload
