# working to add more
Function Show-Installedmodule_dev {
	#Requires -Version 5
	[CmdletBinding()]
	Param(
		$varModules = (Get-InstalledModule)
	)
	Begin {
		"-" * 52
		"`tReporting on {0} modules" -f $varModules.Count
		"-" * 52
		$modReport = [System.Collections.ArrayList]@()
	}# End Begin
	Process {
		ForEach ($mod in $varModules) {
			Try {
				$olInfo = Find-Module -Name $mod.Name
			}
			Catch {
				Write-Error -Message "Unable to find online ref for $($mod.Name)"
			}
			$objDat = [PSCustomObject]@{
				Name      = $mod.Name
				Installed = $mod.Version
				Online    = $olInfo.Version
				Reference = $olInfo.ProjectUri
				# Removing PS Version compatability, inconsistent publishers
				#PS5       = ($mod).Tags -contains 'PSEdition_Desktop'
				#Core = ($mod).Tags -contains 'PSEdition_Core'
			}
			$modReport.Add($objDat) | Out-Null
		}
		$modReport | Format-Table
	}# End Process
	End {
		Remove-Variable varModules, modReport
		[System.GC]::Collect()
	}
}
