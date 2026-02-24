param (
    [string]$featureName
)

if (-not $featureName) {
    Write-Host "Please provide feature name"
    exit
}

$basePath = "lib/features/$featureName"

# Create Main Folders
New-Item -ItemType Directory -Force -Path "$basePath/presentation/widgets"
New-Item -ItemType Directory -Force -Path "$basePath/data/api"
New-Item -ItemType Directory -Force -Path "$basePath/data/data_source_contract"
New-Item -ItemType Directory -Force -Path "$basePath/data/data_source_impl"
New-Item -ItemType Directory -Force -Path "$basePath/data/models"
New-Item -ItemType Directory -Force -Path "$basePath/data/repo_impl"
New-Item -ItemType Directory -Force -Path "$basePath/domain/entities"
New-Item -ItemType Directory -Force -Path "$basePath/domain/repo_contract"
New-Item -ItemType Directory -Force -Path "$basePath/domain/use_cases"

Write-Host "Feature '$featureName' created successfully 🚀"