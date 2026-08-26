# EventViewerScript

A small PowerShell utility for quick Windows Event Viewer auditing. The script filters the System event log for recent errors and warnings and prints a short list of recent events — useful for quick checks, monitoring, or inclusion in automation.

## Features
- Shows recent System-level errors and warnings (Level 2 and 3) from roughly the last 24 hours.
- Returns a limited number of events for quick inspection (default: 10).
- Single-file, zero-dependency PowerShell script that uses built-in cmdlets.

## Requirements
- Windows with PowerShell (Windows PowerShell or PowerShell Core on Windows).
- Permission to read the Windows Event Log (run as a user with sufficient privileges).

## Files
- `EventViewer.ps1` — the script. It builds a filter hashtable and calls `Get-WinEvent` to retrieve matching events.

## Usage
Clone or download the repository and run the script on a Windows machine.

Basic invocation:

```powershell
# From Windows PowerShell (bypass execution policy if needed):
powershell -ExecutionPolicy Bypass -File .\EventViewer.ps1

# From PowerShell Core on Windows:
pwsh -File .\EventViewer.ps1
```

What the script does by default:
- Filters the `System` event log
- `StartTime` is set to `(Get-Date).AddHours(-23)` (last ~23 hours)
- `Level = 2,3` (errors and warnings)
- `-MaxEvents 10` to limit output

You can also dot-source or edit the script to make the filter values configurable (see Suggested improvements).

## Suggested improvements
If you'd like to extend the script, here are common enhancements:
- Add parameters (LogName, HoursBack, Levels, MaxEvents) to call the script with different filters.
- Export results to CSV or JSON for archival or further processing.
- Run as a scheduled task to perform periodic checks and optionally send alerts (email/Slack) when events are found.
- Add nicer formatting or selective property output (Id, TimeCreated, LevelDisplayName, Message, ProviderName).

## Example: parameterized version (concept)
You could change the top of the script to accept parameters like this:

```powershell
param(
  [string]$LogName = 'System',
  [int]$HoursBack = 24,
  [int[]]$Levels = @(2,3),
  [int]$MaxEvents = 10
)

$filter = @{ LogName = $LogName; StartTime = (Get-Date).AddHours(-$HoursBack); Level = $Levels }
Get-WinEvent -FilterHashtable $filter -MaxEvents $MaxEvents | Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, Message
```

## Contributing
Contributions are welcome. Open an issue or submit a PR with enhancements, bug fixes, or additions (for example, parameterization, export formats, or CI for linting).

## License
No license file is included in this repository. If you want to add a license, consider adding an SPDX header and a `LICENSE` file (MIT is common for small utilities).
