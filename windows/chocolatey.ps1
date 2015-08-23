# Run as admin.

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
    $question = "Do you need to install $($packageName)? Defaults to `'$defaultAnswerDisplay`' after $timeout seconds"
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

if (Install-NeededFor 'Git') {
  choco install git -installArguments '"/DIR=C:\\choco\\git"' -params '"/GitOnlyOnPath /NoAutoCrlf"'
}

if (Install-NeededFor 'Ruby') {
  choco install ruby -installArguments '"/tasks=assocfiles,modpath,addtk /dir=C:\\choco\\ruby"'
  gem install bundler
  gem install asciidoctor
}

if (Install-NeededFor 'Python') {
  choco install python2 -overrideArguments -installArguments '" /qn /norestart ALLUSERS=1 TARGETDIR=C:\\choco\\python2"'
  choco install python3 -overrideArguments -installArguments '" /qn /norestart ALLUSERS=1 TARGETDIR=C:\\choco\\python3"'
}
