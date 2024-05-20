# syntax=docker/dockerfile:1

ARG FROM
ARG POWERSHELL_VERSION

# ---------- Stage 1: Download ---------- #

FROM --platform=${TARGETPLATFORM} ${FROM} AS download

ARG _POWERSHELL_ARCHIVE=powershell-${POWERSHELL_VERSION}-${TARGETOS}-${TARGETARCH}.tar.gz
ARG _POWERSHELL_RELEASES_URL=https://github.com/PowerShell/PowerShell/releases
ARG _POWERSHELL_DOWNLOAD_URL=${_POWERSHELL_RELEASES_URL}/download/v${POWERSHELL_VERSION}/${_POWERSHELL_ARCHIVE}

# Download the generic Linux release
ADD ${_POWERSHELL_DOWNLOAD_URL} /tmp/powershell.tar.gz

# Create the directory to extract the downloaded file
RUN mkdir -p /tmp/powershell

# Extract the downloaded file
RUN tar --directory=/tmp/powershell --extract --file=/tmp/powershell.tar.gz --gzip --verbose

# ---------- Stage 2: Install ---------- #

FROM --platform=${TARGETPLATFORM} ${FROM}

# Copy the downloaded files
COPY --from=download ["tmp/powershell", "/opt/microsoft/powershell"]

ARG _EXECUTABLE=/opt/microsoft/powershell/pwsh

RUN \
# Add link to executable
ln --symbolic ${_EXECUTABLE} /usr/bin/pwsh && \
# Make executable executable for all users
chmod a+x ${_EXECUTABLE} && \
# Make executable read-only for other users (all users except the owner)
chmod o-w ${_EXECUTABLE}

# Configure PowerShell
ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV POWERSHELL_UPDATECHECK=Off

# Install .NET 8.0 runtime
RUN \
apk update --no-cache && \
apk add bash=~5.2 --no-cache && \
apk add curl=~8.5 --no-cache && \
curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --architecture "<auto>" --channel "8.0" --install-dir "/usr/share/dotnet" --runtime "dotnet" && \
ln -s "/usr/share/dotnet/dotnet" "/usr/bin/dotnet"

# Configure .NET
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

# Run some PowerShell commands
SHELL ["pwsh", "-Command"]

# Install PowerShell modules
RUN \
if (${USE_PSRESOURCEGET}) { Set-PSResourceRepository -Name "PSGallery" -Trusted } else { Set-PSRepository -InstallationPolicy "Trusted" -Name "PSGallery" } && \
Install-Module -Confirm:$false -Scope "AllUsers" -Name "Pester" -RequiredVersion "5.5.0" && \
Install-Module -Confirm:$false -Scope "AllUsers" -Name "PSScriptAnalyzer" -RequiredVersion "${PSSCRIPTANALYZER_VERSION}"

# Copy a profile
COPY Profile.ps1 /root/.config/powershell/Microsoft.PowerShell_profile.ps1
