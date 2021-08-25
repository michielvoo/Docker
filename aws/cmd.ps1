#!/usr/bin/env pwsh
Switch (3) {
    "docs" {
        Write-Host "docs"
    }
    "test" {
        docker run --rm -it -v ${PWD}:/root/work pester -Output Detailed
    }
    "version" {
        docker run --rm -it aws -Version
        docker run --rm -it --entrypoint git aws --version
    }
}