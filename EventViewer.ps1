$myHashTable =@{ LogName = 'System'; StartTime = (Get-Date).AddHours(-23); Level = 2,3 }

Get-WinEvent -FilterHashtable $myHashTable -MaxEvents 10
