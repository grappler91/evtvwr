$inputTypes = Read-Host "Enter event types (Critical, Error, Warning, Information, Verbose)"
$types = $inputTypes -split "," | ForEach-Object {$_.Trim().ToLower() }

$levelMap = @{
  "critical"    = 1
  "error"       = 2
  "warning"     = 3
  "information" = 4
  "verbose"     = 5
}

$levels = foreach ($type in $types) {
    if ($levelMap.ContainsKey($type)) {
        $levelmap[$type]
    }
}

$filter =@{
    LogName = "System"
    Level   = 1,2,3
    StartTime = (Get-Date).AddHours(-24)
}

Get-WinEvent -FilterHashtable $myHashTable -MaxEvents 10
