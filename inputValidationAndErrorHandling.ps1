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





