# Number of days considered Threshold
$InactiveThreshold = 60

function Print-Menu{
	#Clears user screen for a clean look of the menu
	Clear-Host 
	write-host "Welcome! please select an option below"
	write-host "1) define user inactivity period"
	write-host "2) fetch inactive users"
	write-host "3) change all inactive users"
	write-host "4) change individual inactive users"
 	write-host "Q) Enter Q to Quit"
}

#Option 1 Function - Josh
function Set-InactivePeriod{
	#Paste code here#
}

#Option 2 Function - Brittney
function Get-InactiveUsers{
	#Paste code here#
}

#Option 3 Function - 
function Set-AllInactiveUsers{
	#Paste code here#
}

#Option 4 Function - Luke
function Set-InactiveUser{
	#Paste code here#
}

do {
    Print-Menu
    $choice = read-host "please enter your choice"
    
    switch ($choice) {
        '1' { # Josh 
            Write-Host "Option One"
	    Set-InactivePeriod

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
        'Q' {
            return
        }
        default {
            Write-Host "Invalid selection. Please try again."
            pause
        }
    }
} while ($true)
