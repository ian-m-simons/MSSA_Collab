# Fetch inactive users 

# Not sure how many days we are going with for inactivity 
$inactiveDays = 90

$inactiveDate = (Get-Date).AddDays(-$inactiveDays)

# Retrieves all users in domain I believe? 
$users = Get-ADUser -Filter * -Properties LastLofonDate

# users who have not logged on since inactive date 
$inactiveUsers = $users | Where-Object { $_.LastLogonDate -lt $inactiveDate -or  !&_.LastLogonDate }

# I think this should show the innactive users by name/ account name.
$inactiveUsers | Select-Object Name, SamAccountName, LastLogonDate | Format-Table -AutoSize 


