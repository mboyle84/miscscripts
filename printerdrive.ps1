get-printerdriver | where {$_.ConfigFile -like "*hpc5r5r1*" -or $_.DependentFiles -like "*hpc5r5r1*" -or $_.Monitor -like "*hpc5r5r1*"}
