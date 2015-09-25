# http://www.systemcentercentral.com/automating-application-installation-using-powershell-without-dsc-oneget-2/

$source = 'C:\app'
$InstallDir = 'C:\app'

If (!(Test-Path -Path $source -PathType Container)) {New-Item -Path $source -ItemType Directory | Out-Null}

$packages = @(
@{title='python2';url='https://www.python.org/ftp/python/2.7.10/python-2.7.10.msi';Arguments="/qn /norestart ALLUSERS=1 TARGETDIR=$InstallDir\python2 ADDLOCAL=ALL";Destination=$source},
@{title='python3';url='https://www.python.org/ftp/python/3.5.0/python-3.5.0-webinstall.exe';Arguments="";Destination=$source}
)

foreach ($package in $packages) {
        $packageName = $package.title
        $fileName = Split-Path $package.url -Leaf
        $destinationPath = $package.Destination + "\" + $fileName

If (!(Test-Path -Path $destinationPath -PathType Leaf)) {

    Write-Host "Downloading $packageName"
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile($package.url,$destinationPath)
    }
    }

#Once we've downloaded all our files lets install them.
foreach ($package in $packages) {
    $packageName = $package.title
    $fileName = Split-Path $package.url -Leaf
    $destinationPath = $package.Destination + "\" + $fileName
    $Arguments = $package.Arguments
    Write-Output "Installing $packageName"

Invoke-Expression -Command "$destinationPath $Arguments"
}
