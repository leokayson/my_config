$env.HOME = $env.USERPROFILE

$env.PATH = ($env.PATH | append $"($env.HOME)/env/script/win")