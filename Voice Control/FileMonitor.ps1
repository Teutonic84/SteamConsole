### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = "C:\Users\User\Dropbox\controlcomputer"
    $watcher.Filter = "open game.txt"
    $watcher.IncludeSubdirectories = $false
    $watcher.EnableRaisingEvents = $true

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $action = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                start "C:\SpartanController\Batch FIles\google assistant monitor.bat" -Wait
                Unregister-Event -SourceIdentifier FileCreate
              }    
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -SourceIdentifier FileCreated -Action $action
    #Register-ObjectEvent $watcher "Changed" -Action $action
    #Register-ObjectEvent $watcher "Deleted" -Action $action
    #Register-ObjectEvent $watcher "Renamed" -Action $action
    while ($true) {sleep 4}
