;= @echo off
;= rem %CMDER_HOME%\config\user_aliases.cmd
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here
ex=explorer $*
gl=git log --oneline --all --graph --decorate $*
ls=lsd --icon-theme=unicode -T
ll=lsd --icon-theme=unicode -T -Al --header --date="+%m/%d/%Y %H:%M" $*
lld=fd -l -d 1 $*
alias=code "C:\Users\11409\env\cmder\config\user_aliases.cmd"
reload_a="%CMDER_ROOT%\config\user_aliases.cmd" /reload
reload=%SystemRoot%\System32\cmd.exe /s /k ""C:/Users/11409/env/cmder/vendor/init.bat" /f"
fd=fd -I --color=always $*
btm=btm --config_location=%HOME%\.config\btm.toml
pwd=cd
clear=cls
unalias=alias /d $1
vi=vim $*
cmderr=cd /d "%CMDER_ROOT%"
pwsh=%SystemRoot%/System32/WindowsPowerShell/v1.0/powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -NoExit -Command "Invoke-Expression '. ''%CMDER_ROOT%/vendor/profile.ps1'''"
cr=cargo run $*
cb=cargo build $*
