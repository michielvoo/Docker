BeforeDiscovery {
    Set-Variable "testCases" (Get-DockerTestCases "$PSScriptRoot/Dockerfile")
}

Describe "<Tag> on <Platform>" -ForEach $testCases {
    BeforeAll {
        Write-Warning ($buildArgs | Out-String)
        $buildArgs = $buildArgs.GetEnumerator() | ForEach-Object { "--build-arg"; "$($_.Name)=$($_.Value)" }
        docker build @buildArgs --file "$Dockerfile" --platform "$Platform" --tag "$Tag" "$Context"

        Set-Variable "containerId" $(docker run --detach --interactive --platform "$Platform" --pull "never" --rm "$Tag")

        if (-not $containerId) {
            throw "Abort tests"
        }
    }

    AfterAll {
        if ($containerId) {
            docker stop "$containerId"
        }

        docker image rm --force "$Tag"
    }

    It "has PowerShell 7.2.18" {
        # Act
        $version = docker exec "$containerId" pwsh -Version

        # Assert
        $version | Should -BeExactly "PowerShell 7.2.18"
    }

    It "has Pester 5.5.0" {
        # Act
        $version = docker exec "$containerId" pwsh -Command "(Get-Module Pester).Version.ToString()"

        # Assert
        $version | Should -BeExactly "5.5.0"
    }

    It "has PSScriptAnalyzer 1.21.0" {
        # Act
        $version = docker exec "$containerId" pwsh -Command "(Get-Module PSScriptAnalyzer).Version.ToString()"

        # Assert
        $version | Should -BeExactly "1.22.0"
    }

    It "can be used to exec a command" {
        # Act
        $version = docker exec "$containerId" dotnet --list-runtimes

        # Assert
        $version | Should -BeExactly "Microsoft.NETCore.App 8.0.3 [/usr/share/dotnet/shared/Microsoft.NETCore.App]"
    }
}