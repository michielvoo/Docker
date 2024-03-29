# syntax=docker/dockerfile:1

ARG FROM
ARG PSSCRIPTANALYZER_VERSION
ARG USE_PSRESOURCEGET

FROM mcr.microsoft.com/powershell:${FROM}

ENV POWERSHELL_TELEMETRY_OPTOUT=1
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1

SHELL ["pwsh", "-Command"]

RUN if (${USE_PSRESOURCEGET}) { Set-PSResourceRepository -Name "PSGallery" -Trusted } else { Set-PSRepository -InstallationPolicy "Trusted" -Name "PSGallery" }
RUN Install-Module -Confirm:$false -Scope "AllUsers" -Name "Pester" -RequiredVersion "5.5.0"
RUN Install-Module -Confirm:$false -Scope "AllUsers" -Name "PSScriptAnalyzer" -RequiredVersion "${PSSCRIPTANALYZER_VERSION}"

RUN \
apt-get update \
&& apt-get install -yq "bash" "curl" \
&& apt-get clean \
&& curl -sSL https://dot.net/v1/dotnet-install.sh | bash /dev/stdin --architecture "<auto>" --channel "8.0" --install-dir "/usr/share/dotnet" --runtime "dotnet" \
&& ln -s "/usr/share/dotnet/dotnet" "/usr/bin/dotnet"

COPY Profile.ps1 /root/.config/powershell/Microsoft.PowerShell_profile.ps1
