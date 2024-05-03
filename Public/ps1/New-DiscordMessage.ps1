function New-DiscordMessage {

    [CmdletBinding()]
    [Alias()]

    param (

        [string] $Message,
        [Alias("embed")][PSCustomObject] $embedArray,
        [string] $Username = "Admin",
        [string] $AvatarUrl = $null
    )

    # Create the payload as a PSCustomObject
    $payload = New-Object -TypeName PSCustomObject

    #If the message parameter is filled, add it to the payload
    if ($PSBoundParameters.ContainsKey('Message')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'content' -Value $Message -Force
    }

    #If the embedArray paramater is filled, add it to the payload
    if ($PSBoundParameters.ContainsKey('embedArray')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'embeds' -Value $embedArray -Force
    }

    # If the $Username paramater is filled, pass it to the payload, else default to 'Admin'
    if ($Username -ne "Admin") {
        $payload | Add-Member -MemberType NoteProperty -Name 'username' -Value $Username -Force
    } else {
        $payload | Add-Member -MemberType NoteProperty -Name 'username' -Value $Username -Force
    }

    #if the $AvatarUrl parameter is filled, pass it to the payload
    if ($PSBoundParameters.ContainsKey('AvatarUrl')) {
        $payload | Add-Member -MemberType NoteProperty -Name 'avatar_url' -Value $AvatarUrl -Force
    }
    
    return $payload

}