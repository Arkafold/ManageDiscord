<#
.SYNOPSIS
    Creates a Embed object and adds it to a Discord Webhook Payload
.DESCRIPTION
    This function allows you to create an Discord Embed and add it to your Webhook Payload.
.PARAMETER Payload
    If specified the created Embed will be added to this Payload object. If left empty a new Payload object will be created.
.PARAMETER Title
    If specified will add a Title to the Embed object
.PARAMETER Description
    This is the text in the body of the Embed oject
.PARAMETER ThumbnailUrl
    If specified this will add a Thumbnail image to the Embed object
.PARAMETER Color
    Specifies the color of the sidebar of the Embed object. Takes a interger value. Standard is Green 4289797
.LINK
    https://github.com/Arkafold/ManageDiscord
.EXAMPLE
    Add-DiscordEmbed -Title "Your title here" -Description "Your body message here" -ThumbnailUrl "Https://yourdomain.com/yourimage.png"
    Returns a new Payload object with your embed with a Title, a Description and a Thumbnail
#>

function Add-DiscordEmbed {

    [CmdletBinding()]
    [Alias()]

    param (
        [PSCustomObject] $Payload,
        [string] $Title,
        [string] $Description,
        [string] $ThumbnailUrl,
        [int] $Color = 4289797
    )

    #Create the Embed-object and add the embed to the object
    [System.Collections.ArrayList]$embedArray = @()

    $embedObject = [PSCustomObject]@{
        color = $Color
        title = $Title
        description = $Description
    }

    #If the ThumbnailUrl parameter is passed, create the thumbnailObject and pass this to the embedObject
    if ($PSBoundParameters.ContainsKey('ThumbnailUrl')) {
        $thumbnailObject = [PSCustomObject]@{
            url = $ThumbnailUrl
        }

        $embedObject | Add-Member -MemberType NoteProperty -Name 'thumbnail' -Value $thumbnailObject
    }

    $embedArray.Add($embedObject) | Out-Null

    #Add the Embed-object to the Payload or create a new Payload
    if ($PSBoundParameters.ContainsKey('Payload')) {
        $Payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $embedArray
    } else {
        $Payload = Set-DiscordMessage -embed $embedArray
    }

    return $Payload

}