<#
.SYNOPSIS
    Tests if the Payload is a valid Discord Webhook Payload.
.LINK
    https://github.com/Arkafold/ManageDiscord
.EXAMPLE
    Approve-DiscordPayload -Payload $yourPayload
    Returns $true on succes, throws an error on failure.
#>

function Approve-DiscordPayload {

    [CmdletBinding()]
    [Alias()]
    [OutputType([bool])]

    param (
        [Parameter(Mandatory = $true)]
        [PSCustomObject] $Payload
    )

    #Check if the payload has either the content or the embeds required property
    if (($payload.PSObject.Properties.name -match "content") -or ($payload.PSObject.Properties.name -match "embeds")) {
        return $true
    } else {
        throw "The provided payload did not contain on of the required components. Please add either content or embeds or both."
    }

}