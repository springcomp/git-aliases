git.exe config --global alias.cm '!git checkout master && git merge --ff-only' 
git.exe config --global alias.last 'log -1 HEAD'
git.exe config --global alias.lol 'log --oneline --decorate --graph'
git.exe config --global alias.pristine '!git reset --hard && git clean -dffx'
git.exe config --global alias.stage 'add'
git.exe config --global alias.unstage 'reset HEAD --'

$encodedCommand = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes("& D:/Users/`$Env:USERNAME/AppData/Local/Fork/Fork `$PWD"))
git.exe config --global alias.visual "!powershell.exe -NoProfile -EncodedCommand $encodedCommand"