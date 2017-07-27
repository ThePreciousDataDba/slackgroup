[CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='Medium')]
Param(
	[String]$snippetFolder = Join-Path -Path $env:USERPROFILE -ChildPath "\AppData\Roaming\Code\User\Snippets",
	[String]$url = "https://github.com/jkavanagh58/slackgroup/blob/master/Snippets/vscode/powershell.json"
)
# Archive existing Snippet folder for rollback
If (Test-Path -Path "$snippetFolder\Powershell.json" -PathType Leaf){
	"Archiving current Snippet File"
	Copy-Item -Path "$snippetFolder\PowerShell.json" -Destination "$snippetFolder\Powershell.archive" -Force
}
# Copy file from github repo
$webclient = New-Object System.Net.WebClient
$file = "$snippetFolder\powershell.json"
$webclient.DownloadFile($url,$file)