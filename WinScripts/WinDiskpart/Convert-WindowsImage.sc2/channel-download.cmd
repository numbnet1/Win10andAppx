@echo off
:: delete these comments
::https://yt-dl.org/downloads/2020.07.28/youtube-dl.exe
::https://www.microsoft.com/en-US/download/details.aspx?id=5555
::https://ffmpeg.zeranoe.com/builds/win64/static/ffmpeg-20200818-1c7e55d-win64-static.zip
:: put the youtube-dl and ffmpeg in _app install the msvc++2010x86
cd /D "%~dp0"
setlocal EnableDelayedExpansion
set "arg="
call set "arg=%%1"
if defined arg goto :arg_exists

set "arg=#"
call set "arg=%%1"
if "!arg!" EQU "#" (
    (call set arg=%%1)
    goto :arg_exists
)

set /p arg="Enter link: "

:arg_exists
%cd%\_app\youtube-dl %arg% --no-check-certificate --format bestvideo+bestaudio --merge-output-format mkv --ffmpeg-location %cd%\_app\ffmpeg\bin --output %%(uploader)s/%%(upload_date)s.%%(title)s.%%(id)s.%%(ext)s --restrict-filenames --merge-output-format mkv --ignore-errors

PAUSE