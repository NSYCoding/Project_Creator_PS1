$dir = "$HOME/Github_Projects/";

function Set-GithubDir {
    if (-not (Test-Path -Path $dir)) {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null;
        [string]$inputProjectName = Read-Host "Enter the name of your project";
        $dir = "$dir$inputProjectName/";
        New-Item -Path $dir -ItemType Directory -Force | Out-Null;
        Write-Host "Directory created at $dir";
        Set-Location -Path $dir;
        Set-NodeJSDir;
    }
    else {
        New-Item -Path $dir -ItemType Directory -Force | Out-Null;
        [string]$inputProjectName = Read-Host "Enter the name of your project";
        $dir = "$dir$inputProjectName/";
        New-Item -Path $dir -ItemType Directory -Force | Out-Null;
        Set-Location $dir
        Set-NodeJSDir
    }

    return $dir;
}

function Set-NodeJSDir {
    Set-Location $dir;
    
    [string]$inputNodeJSChoice = Read-Host "Do you want to add NodeJS to your project? (y/n)";
    if ($inputNodeJSChoice -eq "y") {
        npm init -y
        Write-Host "Writing to package.json...";
        Set-ExpressAndSQLite;
        Set-BootstrapOrTailwindCSS;
        Write-Host "package.json created successfully!";
    }
    else {
        Write-Host "Continuing without creating a NodeJS project...";
        return;
    }
}

function Set-BootstrapOrTailwindCSS {
    [string]$inputCSSChoice = Read-Host "Do you want to add Bootstrap or Tailwind CSS to your project? (b/t/n)";

    if ($inputCSSChoice -eq "b") {
        Write-Host "Installing Bootstrap...";
        node.exe npm install bootstrap --save;
        Write-Host "Bootstrap installed successfully!";
    }
    elseif ($inputCSSChoice -eq "t") {
        Write-Host "Installing Tailwind CSS...";
        npm install tailwindcss @tailwindcss/cli --save-dev;
        New-Item -ItemType Directory -Path "src" -Force | Out-Null;
        New-Item -ItemType File -Path "src/input.css" -Force | Out-Null;
        Add-Content -Path "src/input.css" -Value "@import 'tailwindcss';";
        Write-Host "Tailwind CSS installed successfully!";
    }
    elseif ($inputCSSChoice -eq "n") {
        Write-Host "Continuing without adding CSS framework...";
    }
}

function Set-ExpressAndSQLite {
    [string]$inputExpressChoice = Read-Host "Do you want to add Express and SQLite to your project? (y/n)";
    if ($inputExpressChoice -eq "y") {
        Write-Host "Installing Express and SQLite...";
        npm install express sqlite3 --save;
        Write-Host "Express and SQLite installed successfully!";
    }
    else {
        Write-Host "Continuing without adding Express and SQLite...";
    }
}

Set-GithubDir;