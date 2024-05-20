# https://github.com/PowerShell/PowerShell/releases/tag/v6.0.5
# https://github.com/PowerShell/PowerShell/releases/tag/v6.1.6
# https://github.com/PowerShell/PowerShell/releases/tag/v6.2.7
# https://github.com/PowerShell/PowerShell/releases/tag/v7.0.13
# https://github.com/PowerShell/PowerShell/releases/tag/v7.1.7
# https://github.com/PowerShell/PowerShell/releases/tag/v7.2.18
# https://github.com/PowerShell/PowerShell/releases/tag/v7.3.11
# https://github.com/PowerShell/PowerShell/releases/tag/v7.4.1
# https://github.com/PowerShell/PowerShell/releases/tag/v7.5.0-preview.2

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
                        FROM = "alpine:3.17"
                        PS_RELEASE_URL = 


                        PSSCRIPTANALYZER_VERSION = "1.21.0"
                        USE_PSRESOURCEGET = "`$false"
                    }
                    Platform = "linux/amd64"
                }
            )
            Version = "7.2"
        }
    )
}