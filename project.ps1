# Variable for number of days considered Threshold
$global:inactiveDays = ""
$global:inactiveUsers = ""
$global:inactiveThreshold = ""
function Get-Menu{
	#Clears user screen for a clean look of the menu
	
	write-host "Welcome! please select an option below"
	write-host "1) define user inactivity period"
	write-host "2) fetch inactive users"
	write-host "3) change all inactive users"
	write-host "4) change individual inactive users"
 	write-host "0) Enter 0 to Quit"
}

#Option 1 Function - Josh
function Set-InactivePeriod{
	#Paste code here#
    $global:inactiveDays = inputint "Enter number of days for inactivity threshold"
 	$global:inactiveThreshold = (Get-Date).AddDays(-$inactiveDays)
    
    # Retrieves all users in domain I believe? 
	$users = Get-ADUser -Filter * -Properties LastLogonDate


	# users who have not logged on since inactive date 
	$global:inactiveUsers = $users | Where-Object { $_.LastLogonDate -lt $inactiveThreshold -or  !$_.LastLogonDate }

	# I think this should show the innactive users by name/ account name.
	
}

#Option 2 Function - Brittney
function Get-InactiveUsers{
	#Paste code here#
    $inactiveUsers | Select-Object Name, UserPrincipalName, LastLogonDate | Format-Table -AutoSize
}

#Option 3 Function - 
function Set-AllInactiveUsers{
	#Paste code here#
}

#Option 4 Function - Luke
function Set-InactiveUser{
	#Paste code here#
}

#Input Validations below - Ian
# Input Validation - Number of days for Inactive Status
function inputInt(){
	param ([string]$prompt)
	
	$choice = ""
	$success = $false
	while ($success -eq $false){
		$choice = read-host($prompt)
		try{
			$choice = [int]$choice
			$success = $true
		}
		catch{
			write-host "[ERROR] Input must be integer only"
		}
	}
	return $choice
}

# Input Validation - UserName
function UserNameValidation(){
	param([array]$Users, [string]$individual)
	
	$userFound = $false
	for ($i = 0; $i -lt $Users.Length; $i++){
		if ($individual -eq $Users[$i].UserPrincipalName()){
			$userFound = $true
		}
		else{
			continue
		}
	}
	if ($userFound){
		return $true
	}
	else{
		return $false
	}
}

# Main method area starts here
do {
    Get-Menu
    $choice = inputINt "Please Select a number: "   
    switch ($choice) {
        '1' { # Josh 
            Write-Host "`nOption One"
            Set-InactivePeriod
            Write-Host "`nThe inactivity threshold has been set to $inactiveDays days"
            Write-Host "Last logon prior to: `n$inactiveThreshold`n"
        }
        '2' { # Brittney
            Write-Host " Option Two"
	        Get-InactiveUsers
  
        }
        '3' {
            Write-Host " Option Three"
	        Set-AllInactiveUsers

        }
        '4' { #Luke
            Write-Host " Option Four"
	        Set-InactiveUser

        }
        '0' {
            return
        }
        default {
            Write-Host "Invalid selection. Please try again."
            pause
        }
    }
} while ($true)
