function Print-Menu{
	#Clears user screen for a clean look of the menu
	Clear-Host 
	write-host "Welcome! please select an option below"
	write-host "1) define user inactivity period"
	write-host "2) fetch inactive users"
	write-host "3) change all inactive users"
	write-host "4) change individual inactive users"
	$choice = read-host "please enter your choice"
}

function Main(){
	Print-Menu
 }