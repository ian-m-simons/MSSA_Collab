function inputInt(){
	param ([string]$prompt)

	$success = $false
	while ($success -eq $false){
		$choice = read-host($prompt)
		try{
			$choice = [int]$choice





