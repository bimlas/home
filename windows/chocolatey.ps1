# Run as admin.
#
# TODO:
# lua
# tcmd

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
                                                                        # }}}1

if (Install-NeededFor 'Chocolatey') {
  iex ((new-object net.webclient).DownloadString('http://chocolatey.org/install.ps1'))
}

#                            BASE APPLICATIONS                            {{{1
# ============================================================================

if (Install-NeededFor 'Autohotkey') {
  choco install autohotkey.install -installArguments '"/D=C:\choco\autohotkey"'
}

# TODO: Cannot set up install dir. (/e only extracts it)
if (Install-NeededFor 'Conemu') {
  choco install conemu -overrideArguments -installArguments '" /p:x64 /passive TARGETDIR=C:\choco\conemu"'
}

if (Install-NeededFor 'Git') {
  choco install git.install -installArguments '"/DIR=C:\choco\git"' -params '"/GitOnlyOnPath /NoAutoCrlf"'
}

#                               MULTIMEDIA                                {{{1
# ============================================================================

if (Install-NeededFor 'Sumatra Pdf') {
  choco install sumatrapdf.install -installArguments '"/d C:\choco\sumatrapdf /register"'
}

if (Install-NeededFor 'Vlc') {
  choco install vlc -installArguments '"/d C:\choco\sumatrapdf /register"'
}

#                              DEVELOPEMENT                               {{{1
# ============================================================================

if (Install-NeededFor 'Ruby') {
  choco install ruby -installArguments '"/tasks=assocfiles,modpath,addtk /dir=C:\choco\ruby"'
  # TODO
  # choco install ruby2.devkit
}

if (Install-NeededFor 'Ruby Gems') {
  gem install bundler
  gem install asciidoctor
}

if (Install-NeededFor 'Python') {
  choco install python2 -overrideArguments -installArguments '"/qn /norestart ALLUSERS=1 TARGETDIR=C:\choco\python2"'
  choco install python3 -overrideArguments -installArguments '"/qn /norestart ALLUSERS=1 TARGETDIR=C:\choco\python3"'
}
