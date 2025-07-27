@echo off
set WIN_FZF_SELECTED=
set WIN_FZF_ARGS=%1

if "%WIN_FZF_ARGS%" == "cd" (
    goto cd
) else if "%WIN_FZF_ARGS%" == "cd~" (
    goto cd~
) else if "%WIN_FZF_ARGS%" == "cd/" (
    goto cd/
) else if "%WIN_FZF_ARGS%" == "code" (
    goto code
) else if "%WIN_FZF_ARGS%" == "code~" (
    goto code~
) else if "%WIN_FZF_ARGS%" == "code/" (
    goto code/
) else if "%WIN_FZF_ARGS%" == "nvim" (
    goto nvim
) else if "%WIN_FZF_ARGS%" == "nvim~" (
    goto nvim~
) else if "%WIN_FZF_ARGS%" == "nvim/" (
    goto nvim/
) else (
    echo No this cmd
    goto:eof
)

@REM cd
:cd
    for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
    ) else (
        echo go "%WIN_FZF_SELECTED%"
        cd "%WIN_FZF_SELECTED%"
    )
    goto:eof

:cd~
    cd %HOME%
    for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
        cd -
    ) else (
        echo go "%HOME%\%WIN_FZF_SELECTED%"
        cd "%WIN_FZF_SELECTED%"
    )
    goto:eof

:cd/
    cd \
    for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
        cd -
    ) else (
        echo go "\%WIN_FZF_SELECTED%"
        cd "%WIN_FZF_SELECTED%"
    )
    goto:eof

@REM code
:code
    for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,file,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change 
    ) else (
        code "%WIN_FZF_SELECTED%"
    )
    goto:eof

:code~
    cd %HOME%
    for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,file,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
    ) else (
        code "%HOME%\%WIN_FZF_SELECTED%"
    )
    goto:eof

:code/
    cd \
    for /f "delims=" %%i in ('cmd /c "fzf --walker=dir,file,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change 
    ) else (
        code "\%WIN_FZF_SELECTED%"
    )
    goto:eof


@REM nvim
:nvim
    for /f "delims=" %%i in ('cmd /c "fzf --walker=file,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
    ) else (
        nvim "%WIN_FZF_SELECTED%"
    )
    goto:eof

:nvim~
    cd %HOME%
    for /f "delims=" %%i in ('cmd /c "fzf --walker=file,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
    ) else (
        nvim "%WIN_FZF_SELECTED%"
    )
    cd -
    goto:eof

:nvim/
    cd \
    for /f "delims=" %%i in ('cmd /c "fzf --walker=file,hidden"') do set "WIN_FZF_SELECTED=%%i"
    if "%WIN_FZF_SELECTED%" == "" (
        echo No change
    ) else (
        nvim "%WIN_FZF_SELECTED%"
    )
    cd -
    goto:eof