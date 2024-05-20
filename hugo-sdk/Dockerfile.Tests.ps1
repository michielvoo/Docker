BeforeDiscovery {
    Set-Variable "testCases" (Get-DockerTestCases "$PSScriptRoot/Dockerfile")
}

Describe "<Tag> on <Platform>" -ForEach $testCases {
    BeforeAll {
        docker build --file "$Dockerfile" --platform "$Platform" --tag "$Tag" "$Context"
    }

    AfterAll {
        docker image rm --force "$Tag"
    }

    It "has hugo as its entrypoint" {
        # Act
        $output = docker run --rm "$Tag" version

        # Assert
        $output | Should -Match "hugo v0.120.4\+extended .+"
    }

    It "has Git" {
        # Act
        $output = docker run --entrypoint "git" --rm "$Tag" --version

        # Assert
        $output | Should -Match "git version 2\.43\..+"
    }
}