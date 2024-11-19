$users = @()
$input = ""
$userCt = 1

#prompt for user's names. Assemble an array of them all

Write-Host("Enter the names of users to disable, or type done")

read-host("Enter the names of users to disable: ")

While($input -ne "done"){
    $input = Write-Host "User $userCT name: "
    $users += $input
    continue
}
