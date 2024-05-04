<#
.SYNOPSIS
    Sends a Payload to a Discord Webhook.
.DESCRIPTION
    This function takes a PSCustomObject Payload, converts it to JSON and uses the provided Url to send a message to a Discord Webhook.
.PARAMETER Payload
    Mandatory Payload PSCustomObject created by Set-DiscordMessage.
.PARAMETER WebhookUrl
    Mandatory URL of the Webhook of the Discord channel you want your message to be send to.
.PARAMETER LogJson
    Turn on optional output of the Payload as a JSON-file to .\logs\.\logs\Payload.json.
.LINK
    https://github.com/Arkafold/ManageDiscord
.EXAMPLE
    Send-DiscordMessage -Payload $Payload -WebhookUrl "https://discord.com/api/webhooks/etc/etc"
    Takes Payload created with Set-DiscordMessage and send it to the specified Discord Webhook
#>

function Send-DiscordMessage {

    [CmdletBinding()]
    [Alias()]

    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject] $Payload,

        [Parameter(Mandatory = $true)]
        [string] $WebhookUrl,

        [switch] $LogJson
    )

    #Save the Payload as JSON for troubleshooting purposes
    if ($PSBoundParameters.ContainsKey('LogJson')) {
        $Payload | ConvertTo-Json -Depth 100 | Out-File ".\logs\Payload.json" -Force
    }

    try {
        $response = Invoke-RestMethod -Uri $WebhookUrl -Method Post -Body ($Payload | ConvertTo-Json -Depth 100) -ContentType 'Application/Json'
        # Assuming the response is a dictionary, you can access its properties
        $statusCode = $response.StatusCode
        $message = $response.Message
        Write-Verbose "Status Code: $statusCode"
        Write-Verbose "Message: $message"
    } catch {
        # Dig into the exception to get the response details
        if ($_.Exception.Response) {
            $statusCode = $_.Exception.Response.StatusCode.value__
            $statusDescription = $_.Exception.Response.StatusDescription
            Write-Verbose "Status Code: $statusCode"
            Write-Verbose "Status Description: $statusDescription"
        } else {
            Write-Verbose "Error: $_"
        }
    }

}