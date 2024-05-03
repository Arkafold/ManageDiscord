function Add-DiscordEmbed {

    [CmdletBinding()]
    [Alias()]

    param (
        [PSCustomObject] $payload,
        [string] $title,
        [string] $description,
        [int] $color = 4289797
    )

    #Create the Embed-object and add the embed to the object
    [System.Collections.ArrayList]$embedArray = @()

    $embedObject = [PSCustomObject]@{
        color = $color
        title = $title
        description = $description
    }

    $embedArray.Add($embedObject) | Out-Null

    #Add the Embed-object to the payload or create a new payload
    if ($PSBoundParameters.ContainsKey('payload')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $embedArray
    } else {
        $payload = New-DiscordMessage -embed $embedArray
    }
    
    return $payload

} 