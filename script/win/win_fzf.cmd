@echo off
set WIN_FZF_SELECTED=""
set WIN_FZF_ARGS=%1

if "%WIN_FZF_ARGS%" == "cdf" (
    goto cdf
) else if "%WIN_FZF_ARGS%" == "cdc" (
    goto cdc
) else if "%WIN_FZF_ARGS%" == "codef" (
    goto codef
) else if "%WIN_FZF_ARGS%" == "coder" (
    goto coder
)


:cdf
cd \
for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,hidden"') do set "WIN_FZF_SELECTED=%%i"
if "%WIN_FZF_SELECTED%" == "" (
    echo No change
    cd -
) else (
    echo go "%WIN_FZF_SELECTED%"
    cd "%WIN_FZF_SELECTED%"
)
goto:eof

:cdc
for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,hidden"') do set "WIN_FZF_SELECTED=%%i"
if "%WIN_FZF_SELECTED%" == "" (
    echo No change
) else (
    echo go "%WIN_FZF_SELECTED%"
    cd "%WIN_FZF_SELECTED%"
)
goto:eof

:codef
cd \
for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,file,hidden"') do set "WIN_FZF_SELECTED=%%i"
if "%WIN_FZF_SELECTED%" == "" (
    echo No change
    cd -
) else (
    code "%WIN_FZF_SELECTED%"
)
goto:eof

:coder
cd \
for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,file,hidden"') do set "WIN_FZF_SELECTED=%%i"
if "%WIN_FZF_SELECTED%" == "" (
    echo No change
    cd -
) else (
    code -r "%WIN_FZF_SELECTED%"
)
goto:eof
