param (

    [ Switch ][Alias('h')]  $Help,
    [ Switch ][Alias('c')]  $Clean,
    [ Switch ][Alias('r')]  $Release,
    [ Switch ][Alias('x')]  $CopyToWow,
    [ string ][Alias('v')]  $Version = $(Get-Content -Path .\VERSION.txt),
    [ string ][Alias('d')]  $BuildDir = "build",
    [ string ][Alias('n')]  $Name = "Arcadia",
    [ string ][Alias('w')]  $WowDir = "C:\Program Files (x86)\World of Warcraft\_retail_",
    [ string ][Alias('f')]  $TocFile,
    [ string ][Alias('i')]  $InterfaceVersion = "100000"


)

#--------------------------------------------------
# Help
#--------------------------------------------------

if ( $h -or $Help ) {

    Write-Host "build.ps1 - build the project
    
    Usage: build.ps1 [options]

    Options:
        -c, -Clean              clean the project
        -r, -Release            build the project in release mode
        -x, -CopyToWow          copy the build to the wow addons folder
        -n, -Name               the name of the package to build
        -v, -Version            the version of the package to build
        -d, -BuildDir           the directory to build the project in
        -w, -WowDir             copy the build to the specified location
        -f, -TocFile            the toc file to use
        -i, -InterfaceVersion   the interface version to use
    "
    
    exit 
}

#--------------------------------------------------
# Create Build Directory
#--------------------------------------------------

Write-Debug "Creating build directory: $BuildDir"

if ($Clean && Test-Path $BuildDir) {
    Remove-Item -Path $BuildDir -Recurse -Force -ErrorAction SilentlyContinue
    New-Item -Path $BuildDir -ItemType Directory | Out-Null
}


#--------------------------------------------------
# Parse Toc File
#--------------------------------------------------

Write-Debug "Parsing toc file: $($TocFile -Or "template.toc" )"

$Toc

if ($TocFile) {

    $Toc = Get-Content -Path $TocFile

}
else {
    
    $Toc = Get-Content -Path "template.toc"
}


$Toc = $Toc | ForEach-Object {

    if ( $_ -match "^## Interface: \{\{(.+)\}\}$" ) {
        $_ = "## Interface: $InterfaceVersion"
    }

    if ( $_ -match "^## Version: \{\{(.+)\}\}$" ) {
        $_ = "## Version: $Version"
    }

    if ( $_ -match "^## Title: \{\{(.+)\}\}$" ) {
        $_ = "## Title: $Name"
    }

    if ( $_ -match "^## X-Date: \{\{(.+)\}\}$" ) {
        $_ = "## X-Date: $( Get-Date -Format "o" )"
    }

    $_
}

if ( $TocFile ) {

    $Toc | Set-Content -Path $TocFile

}
else {
    
    $Toc | Set-Content -Path "$BuildDir/$Name.toc"
}

#--------------------------------------------------
# Archive Files
#--------------------------------------------------

Write-Debug "Archiving files to: $BuildDir\$Name-$Version.zip"

# set $Toc to the contents of a temporary file
$Toc | Set-Content -Path "$BuildDir\$Name.toc"

Compress-Archive `
    -Path `
    .\docs, `
    .\Icons, `
    .\Libs, `
    .\Locales, `
    .\Rings, `
    "$BuildDir/$Name.toc", `
    .\*.lua, `
    .\*.xml, `
    .\*.txt, `
    .\*.md, `
    .\LICENSE.txt `
    -DestinationPath `
    "$BuildDir\$Name-$Version.zip" `
    -Force

# remove the temporary file
Remove-Item -Path "$BuildDir\$Name.toc"

#--------------------------------------------------
# End Build For No Release and No Copy
#--------------------------------------------------

if (!$Release -And !$CopyToWow) {
    Write-Output "Build complete! ✔️"
    exit
}

#--------------------------------------------------
# Copy To WoW Directory
#--------------------------------------------------

if ( $CopyToWow -and !$Release ) {
    Write-Debug "Copying to WoW directory: $WowDir\Interface\AddOns\$Name"

    if (Test-Path "$WowDir\Interface\AddOns\$Name") {
        Remove-Item -Path "$WowDir\Interface\AddOns\$Name" -Recurse -Force -ErrorAction SilentlyContinue
    }

    Expand-Archive -Path "$BuildDir\$Name-$Version.zip" -DestinationPath "$WowDir\Interface\AddOns\$Name" -Force
}