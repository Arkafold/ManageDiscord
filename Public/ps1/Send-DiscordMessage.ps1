function Send-DiscordMessage {

    [CmdletBinding()]
    [Alias()]

    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject] $payload,

        [Parameter(Mandatory = $true)]
        [string] $WebhookUrl
    )

    $payload | ConvertTo-Json -depth 100 | Out-File ".\logs\payload.json" -Force

    #Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'Application/Json' -Verbose

    try {
        #$response = 
        Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body ($payload | ConvertTo-Json) -ContentType 'Application/Json'
        # Assuming the response is a dictionary, you can access its properties
        <# $statusCode = $response.StatusCode
        $message = $response.Message
        Write-Host "Status Code: $statusCode"
        Write-Host "Message: $message" #>
    } catch {
        # Dig into the exception to get the response details
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
            Write-Host "Status Code: $statusCode"
            Write-Host "Status Description: $statusDescription"
        } else {
            Write-Host "Error: $_"
        }
    }
    
}