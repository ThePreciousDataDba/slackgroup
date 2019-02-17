# Needs CBH
[CmdletBinding()]
Param (
    $snippetURL = "https://gist.github.com/jkavanagh58/9312bd0d78eddc54d51998c0a5c9831a"   
)
BEGIN {
    [System.String]$snippetFolder = Join-Path $env:APPDATA -ChildPath "\code\User\snippets"
    [System.String]$snippetFile = Join-Path $snippetFolder -ChildPath "powershell.json"
    
    If (test-path $snippetFile){
        # Backup the existing Snippet file if it exists
        $snippetBackup = Join-Path $snippetFolder -ChildPath "powershell.bak"
        Rename-Item $snippetFile -NewName $snippetBackup
    }
}
PROCESS {
    Try {
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
        $snip = Invoke-WebRequest -Uri $snippetURL -OutFile $snippetFile -PassThru
    }
    Catch {
        $Error[0].Exception.Message
    }

}