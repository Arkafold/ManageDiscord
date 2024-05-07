function Test-ImageUrl {

    [CmdletBinding()]
    [Alias()]
    [OutputType([string])]

    param (
        [Parameter(Mandatory)] [string] $Url
    )

    #First check if the Url is valid and working
    $response = Invoke-WebRequest -Uri $Url
    
    if ($response.StatusCode -ge 200 -and $response.StatusCode -lt 300) {
        #If the Url is valid, check if it is an image file
        $extension = [System.IO.Path]::GetExtension($url)

        if ($extension -match '\.(jpg|jpeg|png|gif)$') {
            return $Url
        } else {
            throw "The provided URL does not contain a valid image file!"
        }
    } else {
        throw "The provided URL is not valid or working!"
    }
    
}