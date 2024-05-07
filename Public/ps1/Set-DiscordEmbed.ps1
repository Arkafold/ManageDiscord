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
    Set-DiscordEmbed -Title "Your title here" -Description "Your body message here" -ThumbnailUrl "Https://yourdomain.com/yourimage.png"
    Returns a new Payload object with your embed with a Title, a Description and a Thumbnail
#>

function Set-DiscordEmbed {

    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]

    param (
        [PSCustomObject] $Payload,
        [string] $Title,
        [string] $Description,
        [string] $ThumbnailUrl,
        [int] $Color = 4289797,

        [switch] $New,

        [Parameter(ParameterSetName = 'Add')] [switch] $Add,
        [Parameter(Mandatory, ParameterSetName = 'Add')] [System.Collections.ArrayList] $EmbedArray
    )

    #If the paramater New is passed, create a new newEmbedArray and add it to the payload
    if ($PSBoundParameters.ContainsKey("New")) {
        #Create the Embed-object and add the embed to the object
        [System.Collections.ArrayList]$newEmbedArray = @()

        $embedObject = [PSCustomObject]@{
            color = $Color
            title = $Title
            description = $Description
        }

        #If the ThumbnailUrl parameter is passed, create the thumbnailObject and pass this to the embedObject
        if ($PSBoundParameters.ContainsKey('ThumbnailUrl')) {
            New-EmbedThumbnail -ThumbnailUrl $ThumbnailUrl -EmbedObject $embedObject
        }

        $newEmbedArray.Add($embedObject) | Out-Null

        #Add the Embed-object to the Payload or create a new Payload
        if ($PSBoundParameters.ContainsKey('Payload')) {
            $Payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $newEmbedArray
        } else {
            $Payload = Set-DiscordMessage -embed $newEmbedArray
        }

        return $Payload
    } elseif ($PSBoundParameters.ContainsKey("Add")) {
        $embedObject = [PSCustomObject]@{
            color = $Color
            title = $Title
            description = $Description
        }

        #If the ThumbnailUrl parameter is passed, create the thumbnailObject and pass this to the embedObject
        if ($PSBoundParameters.ContainsKey('ThumbnailUrl')) {
            New-EmbedThumbnail -ThumbnailUrl $ThumbnailUrl -EmbedObject $embedObject
        }

        $EmbedArray.Add($embedObject) | Out-Null
    }

}