@{
    Labels = @{
        "org.opencontainers.image.title" = "PowerShell SDK"
        "org.opencontainers.image.description" = "PowerShell, for development of PowerShell modules"
    }
    Variants = @(
        @{
            Platforms = @(
                @{
                    BuildArgs = @{
                        FROM = "lts-7.2-debian-11"
                        PSSCRIPTANALYZER_VERSION = "1.21.0"
                        USE_PSRESOURCEGET = "`$false"
                    }
                    Platform = "linux/amd64"
                }
            )
            Version = "7.2"
        }
        @{
            Platforms = @(
                @{
                    BuildArgs = @{
                        FROM = "7.4-alpine"
                        PSSCRIPTANALYZER_VERSION = "1.22.0"
                        USE_PSRESOURCEGET = "`$false"
                    }
                    Platform = "linux/amd64"
                }
            )
            Version = "7.4"
        }
    )
}