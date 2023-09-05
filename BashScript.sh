# azcopy login --tenant-id "2a8e008e-a080-463e-92b6-8e112be50de6"
UploadFileToBlob () {

    azcopy cp "/home/bhavani/BashScript/$1" \
    "https://uploadfiletoblobshps.blob.core.windows.net/samples-workitems?sp=racwdl&st=2023-09-05T12:23:10Z&se=2023-09-29T20:23:10Z&sv=2022-11-02&sr=c&sig=T0DFxd60l%2FNYKaqEBw8iKF8wYLocaUW7h%2F0IHbCx3fs%3D"
    #- - include-path "$1"
}

GetLatestFile=$(ls -ll | grep -E '^-' | tail -1) 
Filename=$(awk '{print $6,$7,$8,$9}' <<< "$GetLatestFile")

read -a arr <<< "$Filename"

lenFile=$(wc -w <<< "$Filename")
# Sep 5 03:14 filedetails.txt
Fname=""
month=""
day=""
Time=""

for ((n=0; n<=$lenFile-1; n++)); do
   if [ $n == 0 ]; then
       month="${arr[$n]}"
   elif [ $n == 1 ]; then
       day="${arr[$n]}"
   elif [ $n == 2 ]; then
       Time="${arr[$n]}"
   else
      Fname="${arr[$n]}"
   fi
done

Filestamp="Month-${month}-Day-${day}-Time-${Time}-Filename-${Fname}"

LatestOldFile=$(cat "/home/bhavani/BashScript/OldFiles/OldFileDetails.txt" | tail -1)

if [ "$Filestamp" == "$LatestOldFile" ]; then
  echo "matched"
elif [ "$Filestamp" != "$LatestOldFile" ]; then
  UploadFileToBlob $Fname
  echo "Month-${month}-Day-${day}-Time-${Time}-Filename-${Fname}" >> /home/bhavani/BashScript/OldFiles/OldFileDetails.txt 
fi
