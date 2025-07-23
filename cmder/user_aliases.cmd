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
pwd=cd
cd=cd /d $*
clear=cls
unalias=alias /d $1
vi=vim $*
pwsh=%SystemRoot%/System32/WindowsPowerShell/v1.0/powershell.exe -ExecutionPolicy Bypass -NoLogo -NoProfile -NoExit -Command "Invoke-Expression '. ''%CMDER_ROOT%/vendor/profile.ps1'''"

;= rem cmder-related cmd
cmder=code %CMDER_ROOT%
alias=code "%CMDER_ROOT%\config\user_aliases.cmd"  
reload_a="%CMDER_ROOT%\config\user_aliases.cmd" /reload
reload=%SystemRoot%\System32\cmd.exe /s /k ""%CMDER_ROOT%/vendor/init.bat" /f"
cd_cmder=cd /d "%CMDER_ROOT%"

;= rem 3rd-party cmd
;= rem cargo cmds
y=yazi $*
fd=fd -HI --color=always $*
ls=lsd --icon-theme=unicode -T
ll=lsd --icon-theme=unicode -T -Al --header --git --date=relative $*
lls=lsd --icon-theme=unicode -T -Al --header --git --date=relative --total-size $*
lld=fd -l -d 1 $*
btm=btm --config_location=%HOME%\.config\btm.toml $*
cr=cargo run $*
cb=cargo build $*
;= rem git cmds
ga_cnm=git add . && git cnm
;= rem config cmds
scfg=code %HOME%\.config\starship.toml
mycfg=code %HOME%\.config\my_config
