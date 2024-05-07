function Add-EmbedThumbnail {
    
    [CmdletBinding()]
    [Alias()]
    [OutputType([PSCustomObject])]
    
    param (
        [Parameter(Mandatory)] [PSCustomObject] $EmbedObject,
        [Parameter(Mandatory)] [string] $ThumbnailUrl
    )

    $thumbnailObject = [PSCustomObject]@{
        url = $ThumbnailUrl
    }

    $EmbedObject | Add-Member -MemberType NoteProperty -Name 'thumbnail' -Value $thumbnailObject

    return $EmbedObject
    
}