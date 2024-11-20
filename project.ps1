# Variable for number of days considered Threshold
$global:inactiveDays = ""
$global:inactiveUsers = ""
$global:inactiveThreshold = ""

#########################
# Menu Option Functions #
#########################

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
    $global:inactiveDays = inputInt "Enter number of days for inactivity threshold"
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
    $inactiveUsers | Select-Object Name, SamAccountName, LastLogonDate | Format-Table -AutoSize
}

#Option 3 Function - 
function Disable-AllInactiveUsers{
	#Paste code here#
}

#Option 4 Function - Luke
function Disable-InactiveUser{
	param([array]$ListOfUsers)

    $users = @()
    $UserInput = ""


    #prompt for user's names. Assemble them in an array

    Write-Host("Enter the names of users to modify, or type done")
    $UserInput = read-host "User "($users.Length + 1)" name: "


    While($UserInput -ne "done"){
        $UInputSuccess = $false
        <#While($UInputSuccess -eq $false){
            $UInputSuccess = UserNameValidation($UserInput)
            if $UInputSuccess -eq $false {
                Write-Host "Error: User not found"
                $UserInput = read-host "User $users.Length name: "
            }
        }#>
        $users += $UserInput
        $UserInput = read-host "User "($users.Length + 1)" name: "
    }

    Write-Host "What would you like to do with these Users?"
    Write-Host "1: Disable Users"
    Write-Host "2: Come Back later I can't do anything else yet"

    $UserAction = inputInt("Option: ")

    if($UserAction -eq 1){
        foreach($U in $users){
            Disable-ADAccount -identity $U
            Write-Host "'n$U's Account has been disabled`n"

            # Maybe we can incorporate 
            Get-ADUser -Filter "Name -Like '*$U*'" | ForEach-OBject{
                Write-Host "Name: $($_.Name)"
                Write-Host "Enabled: $($_.Enabled)`n"
            }

        }
    }
}
#$testUsers = @("Bill","Jack","Harry")

#ChangeInactiveUser($testUsers)
#ChangeInactiveUser $testUsers

#########################
#### Other Functions ####
#########################

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

#Error Handling Functions - Ian
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
    $choice = inputInt "Please Select a number: "   
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
	        Disable-AllInactiveUsers

        }
        '4' { #Luke
            Write-Host " Option Four"
	        Disable-InactiveUser


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
