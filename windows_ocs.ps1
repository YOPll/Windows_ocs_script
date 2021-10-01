#Set DATA here
###########################################################################

# OCS Infos
$ocsversion="2.6.0.1"
$ocsserver="" # Must be http[s]://server.domain.tld[:port]/ocsinventory with ca.crt or /ssl=0
$ocspackage="OCS-NG-Windows-Agent-Setup-$ocsversion.exe"
$nasurldir=""

#Set DATA here - END
###########################################################################

# Main Script

# Check if an OCS is already installed

# Check if 32 bits OCS is installed

if (Test-Path "${Env:PROGRAMFILES(X86)}\OCS Inventory Agent\ocsinventory.exe") {
	Write-Host ("`n`t  ## OCS 32 bits is already installed with the TAG bello ## `n")
	cat "${Env:PROGRAMDATA}\OCS Inventory NG\Agent\admininfo.conf"
	
	# Uninstall 32 bits OCS
	Write-Host ("`n`n`t  ## Uninstalling OCS 32 bits  ## `n")
	Write-Host ("`n Wait Please ... ")
	Start-Process "${Env:PROGRAMFILES(X86)}\OCS Inventory Agent\uninst.exe" -ArgumentList '/S' -Wait
}

# Install OCS $ocspackage 
###########################################################################

[string]$ocstag = $( Read-Host "`t`t  ## Input your Full Name Please " )

	Write-Host ("`n`n`t ## Install OCS with TAG : $ocstag ## `n")
	
		pause
		
		$Env:OCSTAG=$ocstag
		$Env:VERSION=$ocsversion
		$Env:OCSSERVER=$ocsserver
		
		if (Test-Path "$Env:TEMP\$ocspackage") {
			Write-Host ("`n`n`t  ## $ocspackage Exist ## `n")
		}
		else {
			Write-Host "`n`n # OCS NOT exist # So Download $ocspackage `n"
			
			wget $nasurldir/$ocspackage -O "$Env:TEMP\$ocspackage" 
		}
		
		Write-Host ("`n`n`t  ## Installing OCS with TAG : $Env:OCSTAG ## `n")
		Write-Host ("`n Wait Please ... ")
		Start-Process "$Env:TEMP\$ocspackage" -ArgumentList '/S','/force',"/SERVER=$Env:OCSSERVER",'/ssl=0','/NOSPLASH','/no_systray','/uid','/DEBUG','/NOW',"/TAG=$Env:OCSTAG" 
		Write-Host ("`n`n`t  ##  OCS Install Will Be Finishing on several time ## `n")

# Install OCS $ocspackage  - END
###########################################################################

pause


# FIN
