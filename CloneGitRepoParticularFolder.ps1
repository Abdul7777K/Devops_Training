$Q = 0
do {
$newfolder = Read-Host "Enter new folder name to create: "
$path = "D:\" + $newfolder
if (-Not (Test-Path -Path $path) ) {
   Write-Host "$path absent from the location so, Creating A new Folder name $newfolder"
   mkdir $newfolder
   cd $path
   git init
   git remote add origin https://github.com/purushothamreddyaccionlabs/Angular_DotNET_Projects.git
   git config core.sparseCheckout true
   git sparse-checkout set EshopApplication
   git pull origin master
   Write-Host "Clone Successfull"
   cd ..
   $E = Read-Host "Enter a Exit Word to Exit:  "
   if ($E -eq "Exit"){
         Break
     }
}
elseif (Test-Path -Path $path) {
    Write-Host "Already Exist"
    $Q++
}
} while ($Q -gt 0)





