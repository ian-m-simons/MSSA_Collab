
function UserNameValidation(){
	param([array]$Users, [string]$individual)
	
	$userFound = $false
	for ($i = 0; $i -lt $Users.Length; $i++){
		if $individual -eq $Users[$i].UserPrincipalName(){
			$userFound = $true
		}
		else{
			continue
		}
	}
	if $userFound{
		return $true
	}
	else{
		return $false
	}

}

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


function ChangeInactiveUser() {
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
        }
    }
}
$testUsers = @("Bill","Jack","Harry")

#ChangeInactiveUser($testUsers)
ChangeInactiveUser $testUsers