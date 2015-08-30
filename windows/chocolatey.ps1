# Run as admin.
#
# TODO:
# rbtray?
# free countdown timer?
# zeal?
# 4k video downloader?
# https://chocolatey.org/packages/ctags
# https://chocolatey.org/packages/Lua
# https://chocolatey.org/packages/ActivePerl
# https://chocolatey.org/packages/ActiveTcl
# https://chocolatey.org/packages/mingw
# https://chocolatey.org/packages/f.lux
# https://chocolatey.org/packages/Devbox-RapidEE
# https://chocolatey.org/packages/TotalCommander
# https://chocolatey.org/packages/Firefox
# https://chocolatey.org/packages/thunderbird
# https://chocolatey.org/packages/gimp
# https://chocolatey.org/packages/InkScape
# https://chocolatey.org/packages/libreoffice
# https://chocolatey.org/packages/handbrake.install

$InstallDir = "c:\choco"

#                            INSTALL FUNCTION                             {{{1
# ============================================================================

function Install-NeededFor {
param(
   [string] $packageName = ''
  ,[bool] $defaultAnswer = $true
)
  if ($packageName -eq '') {return $false}

  $yes = '6'
  $no = '7'
  $msgBoxTimeout='-1'
  $defaultAnswerDisplay = 'Yes'
  $buttonType = 0x4;
  if (!$defaultAnswer) { $defaultAnswerDisplay = 'No'; $buttonType= 0x104;}

  $answer = $msgBoxTimeout
  try {
    $timeout = 10
    $question = "Install $($packageName)? Defaults to `'$defaultAnswerDisplay`' after $timeout seconds"
    $msgBox = New-Object -ComObject WScript.Shell
    $answer = $msgBox.Popup($question, $timeout, "Install $packageName", $buttonType)
  }
  catch {
  }

  if ($answer -eq $yes -or ($answer -eq $msgBoxTimeout -and $defaultAnswer -eq $true)) {
    write-host "Installing $packageName"
    return $true
  }

  write-host "Not installing $packageName"
  return $false
}

if (Install-NeededFor 'Chocolatey') {
  iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))
}

#                            BASE APPLICATIONS                            {{{1
# ============================================================================

if (Install-NeededFor 'BASE APPLICATIONS') {
  if (Install-NeededFor 'BASE APPLICATIONS / Autohotkey') {
    choco install autohotkey.install -installArguments "/D=$InstallDir\autohotkey"
  }

# TODO: Cannot set up install dir. (/e only extracts it)
  if (Install-NeededFor 'BASE APPLICATIONS / Conemu') {
    choco install conemu -overrideArguments -installArguments " /p:x64 /passive TARGETDIR=$InstallDir\conemu"
  }

  if (Install-NeededFor 'BASE APPLICATIONS / Git') {
    choco install git.install -installArguments "/DIR=$InstallDir\git" -params "/GitOnlyOnPath /NoAutoCrlf"
  }
}

#                               MULTIMEDIA                                {{{1
# ============================================================================

if (Install-NeededFor 'MULTIMEDIA') {
  if (Install-NeededFor 'MULTIMEDIA / Sumatra Pdf') {
    choco install sumatrapdf.install -installArguments "/d $InstallDir\sumatrapdf /register"
  }

# TODO: Set up install dir.
  if (Install-NeededFor 'MULTIMEDIA / Vlc') {
    New-Item -Path HKLM:\SOFTWARE\VideoLAN\VLC -Force
    New-ItemProperty -Path HKLM:\SOFTWARE\VideoLAN\VLC -Name "InstallDir" -Value "$InstallDir\vlc" -Force
    choco install vlc
  }
}

#                              DEVELOPEMENT                               {{{1
# ============================================================================

if (Install-NeededFor 'DEVELOPEMENT') {
  if (Install-NeededFor 'DEVELOPEMENT / Ruby') {
    choco install ruby -installArguments "/tasks=assocfiles,modpath,addtk /dir=$InstallDir\ruby"
    # TODO: choco install ruby2.devkit
  }

  if (Install-NeededFor 'DEVELOPEMENT / Ruby Gems') {
    gem install bundler
    gem install asciidoctor
  }

  if (Install-NeededFor 'DEVELOPEMENT / Python') {
    # TODO: add to path (the DLLs too)
    choco install python2 -overrideArguments -installArguments "/qn /norestart ALLUSERS=1 TARGETDIR=$InstallDir\python2"
    choco install python3 -overrideArguments -installArguments "/qn /norestart ALLUSERS=1 TARGETDIR=$InstallDir\python3"
  }
}
