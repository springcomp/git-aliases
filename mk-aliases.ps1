git.exe config --global alias.cm '!git fetch --all -p && git checkout master && git merge --ff-only origin/master' 
git.exe config --global alias.cmn '!git fetch --all -p && git checkout main && git merge --ff-only origin/main' 
git.exe config --global alias.istage '!git-istage'
git.exe config --global alias.last 'log -1 HEAD'
git.exe config --global alias.lol 'log --oneline --decorate --graph'
git.exe config --global alias.pristine '!git reset --hard && git clean -dffx'
git.exe config --global alias.undo 'checkout HEAD^1 --'
git.exe config --global alias.stage 'add'
git.exe config --global alias.unstage 'restore --staged'
git.exe config --global alias.uncommit 'reset --soft HEAD^'

$encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("& `$Env:LOCALAPPDATA/Fork/Fork `$PWD"))
git.exe config --global alias.visual "!powershell.exe -NoProfile -EncodedCommand $encodedCommand"

$gb = Get-Content -Path "$($PSScriptRoot)/git-browse.ps1" -Raw
$encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("$($gb); BrowseTo-GitRepository -remote (git remote get-url --push origin)"))
git.exe config --global alias.browse "!powershell.exe -NoProfile -EncodedCommand $encodedCommand"