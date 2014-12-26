#sync to folders and create an event in eventviwer if it fails
#RUN as administrator to write into eventlog
#Just one time for the eventlog source creation
#New-EventLog -Source Robocopy -LogName Application

Param(
  [string]$source,
  [string]$destination,
  [string]$copyname="IISDATA",
  [string]$extraoption,
  [string]$logpathname="c:\tmp\"+$copyname+"-"+$(Get-Date -format dd-MM-yyyy)+".log"
)

#force params
$source="\\XXXX\dfs\IISDATA\"
$destination="\\YYYY\IISDATA\"
$extraoption=""

#Sync files and folder
$cmdArgs = @("$source","$destination","/mir","/256","/NP", "/COPY:DATSOU","/MT:8", "/r:3", "/w:3", $extraoption, "/log:$logpathname")
#Sync only folders
#$cmdArgs = @("$source","$destination","/mir","/256","/NP", "/COPY:DATSOU","/MT:8", "/r:3", "/w:3","/xf *", $extraoption, "/log:$logpathname")
try
{
 
     
     robocopy  $cmdArgs
     
     
}

catch 
{
    Write-Host "Other exception"
}


#uncoment to write into the eventlog

switch ($lastexitcode)
{
    '0' {
    write-host -ForegroundColor Green " No errors occurred, and no copying was done.The source and destination directory trees are completely synchronized.  $lastexitcode"}
    '1' {write-host -ForegroundColor Green " One or more files were copied successfully (that is, new files have arrived). $lastexitcode"}
    '2' {write-host -ForegroundColor Green "Some Extra files or directories were detected. No files were copied Examine the output log for details.  $lastexitcode"}
    '3' {write-host -ForegroundColor Yellow "(2+1) Some files were copied. Additional files were present. No failure was encountered."}
    '4' {write-host -ForegroundColor Yellow "Some Mismatched files or directories were detected.Examine the output log. Some housekeeping may be needed. $lastexitcode " 
     #Write-EventLog -LogName application -EventId 666 -EntryType warning -Source Robocopy  -Message "Review LOG"
     }
    '5' {write-host -ForegroundColor Yellow "(4+1) Some files were copied. Some files were mismatched. No failure was encountered. $lastexitcode"
     #Write-EventLog -LogName application -EventId 666 -EntryType warning -Source Robocopy  -Message "Review LOG"
     }
    '6' {write-host -ForegroundColor Yellow "(4+2) Additional files and mismatched files exist. No files were copied and no failures were encountered.This means that the files already exist in the destination directory  $lastexitcode"
     #Write-EventLog -LogName application -EventId 666 -EntryType warning -Source Robocopy  -Message "Review LOG"
     }
    '7' {write-host -ForegroundColor Yellow "(4+1+2) Files were copied, a file mismatch was present, and additional files were present."
    #Write-EventLog -LogName application -EventId 666 -EntryType warning -Source Robocopy  -Message "Review LOG"
    }
    #Any value greater than 8 indicates that there was at least one failure during the copy operation.
    '8' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
    '9' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
    '10' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
    '11' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
    '12' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
    '13' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
   '14' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
    '15' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }

    '16' {write-host -ForegroundColor Red "FATAL ERROR REVIEW LOG (http://ss64.com/nt/robocopy-exit.html) $lastexitcode  "
     # Write-EventLog -LogName application -EventId 666 -EntryType Error -Source Robocopy  -Message "FATAL ERROR REVIEW LOG"
    }
            
    Default {write-host -ForegroundColor red "Unknow error, review log. $lastexitcode"}
}


