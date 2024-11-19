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



