$global:sas_token="?sv=2022-11-02&ss=bq&srt=sco&sp=rwdlacupiytfx&se=2023-09-30T15:41:44Z&st=2023-09-05T07:41:44Z&spr=https&sig=kFU6zCF8gkKdd3ILo14Jv1%2F%2FZrHdm0MR%2BwBt7RZd3tM%3D"
$global:account_name = "uploadfiletoblobshps"
#generate the context
$global:context = New-AzStorageContext -StorageAccountName $account_name -SasToken $sas_token
$global:Sentmail = 0

function SendMessagesToQueue {
    [CmdletBinding()]
    param (
       # [Parameter(Mandatory=$true)]
       # [string[]]$context,
        [Parameter(Mandatory=$true)]
        [string[]]$Message
    )
    
    # Retrieve a specific queue
    $queue = Get-AzStorageQueue –Name sendblobnotification –Context $context

    # Retrieve all queues and show their names
    Get-AzStorageQueue -Context $context | Select-Object Name

    $queueMessage = [Microsoft.Azure.Storage.Queue.CloudQueueMessage]::new("$Message")
    $queue.CloudQueue.AddMessageAsync($queueMessage)

    # Call the GetAndSendMessage function
    GetAndSendMessage
    DeleteMessageFromQueue -Sentmail "$Sentmail"

}

function GetAndSendMessage {
   
    $invisibleTimeout = [System.TimeSpan]::FromSeconds(10)
    $queueMessage = $queue.CloudQueue.GetMessageAsync($invisibleTimeout,$null,$null)
    $Finalmessage = $queueMessage.Result.AsString

    # Call the SendMail function and pass $Finalmessage as a parameter
    SendMail -MessageContent $Finalmessage
}

function SendMail {
    param ( 
        [Parameter(Mandatory=$true)]
        [string]$MessageContent
    )

    $pass = ConvertTo-SecureString "A7Abdul@1998" -AsPlainText -Force
    $Creds = New-Object System.Management.Automation.PSCredential ('abdul.kutagolla@accionlabs.com', $pass)

    try {
        $Datetime = Get-Date -UFormat "%A %Y %R"
        $j = $Datetime.Split(" ")
        $SubDateFormat = [string]::Format("NotificationFromBlob-Have A Look-{0}-{1}-{2}",$j[0],$j[1],$j[2])
        Send-MailMessage -To "nameabdul98@gmail.com" -Subject $SubDateFormat -Body $MessageContent -From "abdul.kutagolla@accionlabs.com" -SmtpServer "smtp.gmail.com" -Port 587 -Credential $Creds -UseSsl
    }
    catch [System.Net.WebException],[System.IO.IOException] {
        $Global:Sentmail = 1
    }             
}



function DeleteMessageFromQueue {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Sentmail
    )

    if( $Sentmail -eq 0) {
        $queue.CloudQueue.DeleteMessageAsync($queueMessage.Result.Id,$queueMessage.Result.popReceipt)
        $queueMessage = $queue.CloudQueue.GetMessageAsync($invisibleTimeout,$null,$null)
        $queueMessage.Result
    }else {
        GetAndSendMessage
    }
    
}

$Blobs = Get-AzStorageBlob -Container "uploadfilestoblob" -Context $context |
  Select-Object -Property Name, LastModified

$Message = [string]::Format("The File {0} is Recently Uploaded on {1} into Blob please have a look!", $Blobs[0].Name, $Blobs[0].LastModified)



#executions
SendMessagesToQueue -Message $Message
