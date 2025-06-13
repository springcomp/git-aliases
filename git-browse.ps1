Function BrowseTo-GitRepository {
	[CmdletBinding()]
	[Alias("origin")]
	param(
        [string]$remote = $(git config --get remote.origin.url)
    )

    if (!$remote) {
        Write-Output "No Git URL found"
        break
    }


	$matchings = @{
		"github-ssh"=@("^git@(ssh\.)?github.com:(?<user>.+)\/(?<git>.*)\.git$", "https://github.com/%user%/%git%")
		"github-https"=@("^https://github.com/(?<user>.+)/(?<git>.*)$", "https://github.com/%user%/%git%")
		"azure-devops-https"=@("https://[^@]+@dev.azure.com/(?<tenant>.+)/(?<project>.+)/_git/(?<git>.*)$", "https://dev.azure.com/%tenant%/%project%/_git/%git%")
		"azure-devops-ssh"=@("^git@ssh.dev.azure.com:v3/(?<tenant>.+)/(?<project>.+)/(?<git>.*)$", "https://dev.azure.com/%tenant%/%project%/_git/%git%")
	}

	$matchings.Keys |% {
		$name = $_
		$pattern = $matchings[$name][0]
		$url = $matchings[$name][1]

		Write-Verbose "Checking $name repository: $pattern"

		if ($remote -match $pattern) {

			$address = $url

			$kv = $matches
			$kv.Keys |? { $_ -match "^[A-Za-z_]" } |% {
				$placeholder = $_
				$replacing = $kv[$placeholder]
				Write-Verbose "$($placeholder): $replacing"

				$replaced = "%$($placeholder)%"
				$address = $address.Replace($replaced, $replacing)
			}

			Write-Verbose "Navigating to $address"
			Invoke-Expression "start $address"
		}
	}
}