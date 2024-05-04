<#
.SYNOPSIS
    Creates a new Payload for use in a Discord Webhook.
.DESCRIPTION
    Creates a PSCustomObject payload for use with the Send-DiscordMessage function. Returns a PSCustomObject.
.PARAMETER Message
    A plain text message to be displayed in the Discord channel.
.PARAMETER EmbedArray
    An array of Embed objects created by the Add-DiscordEmbed function. Accepts a PSCustomObject.
.PARAMETER Username
    The username to be displayed as the sender of the message. Defaults to Admin
.PARAMETER AvatarUrl
    Optional URL for a avatar to be displayed next to the username.
.LINK
    https://github.com/Arkafold/ManageDiscord
.EXAMPLE
    New-DiscordMessage -Message "Your message here" -Username "YourUsername" -AvatarUrl "https://yourdomain.com/youravatar.png"
    Returns a PSCustomObject payload for use with the Send-DiscordMessage function.
#>

function New-DiscordMessage {

    [CmdletBinding()]
    [Alias()]

    param (

        [string] $Message,
        [Alias("embed")][PSCustomObject] $EmbedArray,
        [string] $Username = "Admin",
        [string] $AvatarUrl
    )

    # Create the payload as a PSCustomObject
    $payload = New-Object -TypeName PSCustomObject

    # If the $Username paramater is filled, pass it to the payload, else default to 'Admin'
    $payload | Add-Member -MemberType NoteProperty -Name 'username' -Value $Username -Force

    #If the message parameter is filled, add it to the payload, else pass null
    if ($PSBoundParameters.ContainsKey('Message')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'content' -Value $Message -Force
    } else {
        $payload | Add-Member -MemberType NoteProperty -Name 'content' -Value $null -Force
    }

    #if the $AvatarUrl parameter is filled, pass it to the payload
    if ($PSBoundParameters.ContainsKey('AvatarUrl')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'avatar_url' -Value $AvatarUrl -Force
    }

    #If the EmbedArray paramater is filled, add it to the payload
    if ($PSBoundParameters.ContainsKey('EmbedArray')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $EmbedArray -Force
    }
    
    return $payload

}