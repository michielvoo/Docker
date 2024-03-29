@{
    Labels = @{
        "org.opencontainers.image.title" = "Hugo SDK"
        "org.opencontainers.image.description" = "Hugo Extended and Git, for building static websites"
    }
    Variants = @(
        @{
            Platforms = @(
                @{
                    Platform = "linux/amd64"
                }
                @{
                    Platform = "linux/arm64"
                }
            )
            Version = "0.0.1"
        }
    )
}