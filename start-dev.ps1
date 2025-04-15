# PowerShell script for Windows users to start the development environment

# Check if .env file exists, create from example if it doesn't
if (-not (Test-Path .\.env)) {
    Write-Host "Creating .env file from template..."
    Copy-Item .\.env.example .\.env
}

# Check if FIRST_TIME_RUN is set in .env
$envContent = Get-Content .\.env -ErrorAction SilentlyContinue
$firstTimeRun = $false

foreach ($line in $envContent) {
    if ($line -match "FIRST_TIME_RUN=true") {
        $firstTimeRun = $true
        break
    }
}

if (-not $firstTimeRun) {
    Write-Host "Environment variable 'FIRST_TIME_RUN' not set to true."
    $confirm = Read-Host "Is this your first time setting up the Scraper project? (Y/N)"
    
    if ($confirm -eq "Y") {
        Write-Host "Setting up environment..."
        Add-Content -Path .\.env -Value "FIRST_TIME_RUN=true"
        $firstTimeRun = $true
    } else {
        Write-Host "Aborting setup."
        Exit 1
    }
}

# If this is the first run, check for repositories
if ($firstTimeRun) {
    # Check and clone repositories if they don't exist
    $repos = @(
        @{Name="Scraper-Manager"; Url="https://github.com/MetaBundleAutomation/Scraper-Manager"},
        @{Name="Scraper-Dashboard"; Url="https://github.com/MetaBundleAutomation/Scraper-Dashboard"},
        @{Name="Scraper-Instance"; Url="https://github.com/MetaBundleAutomation/Scraper-Instance"}
    )
    
    foreach ($repo in $repos) {
        if (-not (Test-Path ".\$($repo.Name)")) {
            Write-Host "Cloning $($repo.Name) repository..."
            git clone $repo.Url
        }
    }
}

# Build and start the Docker Compose stack
Write-Host "Starting development environment..."
docker-compose up --build

Write-Host "Development environment is now running. Press Ctrl+C to stop."
