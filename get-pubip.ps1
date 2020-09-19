[CmdletBinding()]
Param (
	[parameter(Mandatory = $False, ValueFromPipeline = $True,
		HelpMessage = 'IP4 Output')]
	[Switch]$IPV4,
	[parameter(Mandatory = $False, ValueFromPipeline = $True,
		HelpMessage = 'IP6 Output')]
	[Switch]$IPV6
)
If ($IPV4) {
	(Invoke-WebRequest -Uri 'https://ipv4.icanhazip.com/').content
}
If ($IPV6) {
	(Invoke-WebRequest -Uri 'https://ipv6.icanhazip.com/').content
}