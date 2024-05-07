<#
.SYNOPSIS
    Creates an Embed object and adds it to an Embed Array for use in a Discord Webhook Payload
.DESCRIPTION
    This function allows you to create an Discord Embed and add it to your Embed Array, or create a new Embed Array if you don't already have one.
.PARAMETER Title
    If specified will add a Title to the Embed object.
.PARAMETER Description
    This is the text in the body of the Embed oject.
.PARAMETER ThumbnailUrl
    If specified this will add a Thumbnail image to the Embed object.
.PARAMETER Color
    Specifies the color of the sidebar of the Embed object. Takes a interger value. Standard is Green 4289797.
.PARAMETER New
    Specifies that you want to create a new EmbedArray.
.PARAMETER Add
    Specifies that you want to add an Embed Object to your Embed Array.
.PARAMETER EmbedArray
    Takes a ArrayList of Embeds to add the new Embed Object to.
.LINK
    https://github.com/Arkafold/ManageDiscord
.EXAMPLE
    Set-DiscordEmbed -New -Title "Your title here" -Description "Your body message here" -ThumbnailUrl "Https://yourdomain.com/yourimage.png"
    Returns a new EmbedArray ArrayList with your embed with a Title, a Description and a Thumbnail
.EXAMPLE
    Set-DiscordEmbed -Add -Title "Your title here" -Description "Your body message here" -ThumbnailUrl "Https://yourdomain.com/yourimage.png" -EmbedArray $yourEmbedArray
    Adds your specified new Embed Object to your existing EmbedArray
#>

function Set-DiscordEmbed {

    [CmdletBinding(SupportsShouldProcess)]
    [Alias()]
    [OutputType([System.Collections.ArrayList])]

    param (
        [string] $Title,
        [string] $Description,
        [string] $ThumbnailUrl,
        [int] $Color = 4289797,

        [Parameter(Mandatory, ParameterSetName = 'New')] [switch] $New,

        [Parameter(Mandatory, ParameterSetName = 'Add')] [switch] $Add,
        [Parameter(Mandatory, ParameterSetName = 'Add')] [System.Collections.ArrayList] $EmbedArray
    )

    #If the paramater New is passed, create a new newEmbedArray and add it to the payload
    if ($New) {
        if ($PSCmdlet.ShouldProcess("Embed Array", "create new")) {
            #Create the Embed-object and add the embed to the object
            [System.Collections.ArrayList]$newEmbedArray = @()
    
            $embedObject = [PSCustomObject]@{
                color = $Color
                title = $Title
                description = $Description
            }
    
            #If the ThumbnailUrl parameter is passed, create the thumbnailObject and pass this to the embedObject
            if ($PSBoundParameters.ContainsKey('ThumbnailUrl')) {
                $url = Test-ImageUrl -Url $ThumbnailUrl
                Add-EmbedThumbnail -ThumbnailUrl $url -EmbedObject $embedObject
            }
    
            $newEmbedArray.Add($embedObject) | Out-Null
    
            return $newEmbedArray
        }

    } elseif ($Add) {
        if ($PSCmdlet.ShouldProcess("Embed Array", "Add new Embed")) {
            $embedObject = [PSCustomObject]@{
                color = $Color
                title = $Title
                description = $Description
            }
    
            #If the ThumbnailUrl parameter is passed, create the thumbnailObject and pass this to the embedObject
            if ($PSBoundParameters.ContainsKey('ThumbnailUrl')) {
                Add-EmbedThumbnail -ThumbnailUrl $ThumbnailUrl -EmbedObject $embedObject
            }
    
            $EmbedArray.Add($embedObject) | Out-Null
    
            return $EmbedArray
        } 
    }

}