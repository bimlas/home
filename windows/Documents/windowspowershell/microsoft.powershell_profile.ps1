# Powershell Improved
#
# First You need to install Powershell 3:
#
#   Powershell 3
#   http://www.microsoft.com/en-us/download/details.aspx?id=34595
#     x86 Windows6.1-KB2506143-x86.msu
#     x64 Windows6.1-KB2506143-x64.msu
#
# Powershell 3 needs Service Pack 1 and (at least) .Net 4.0:
#
#   Service Pack 1
#   http://windows.microsoft.com/en-us/windows7/install-windows-7-service-pack-1
#
#   .Net 4.0
#   http://www.microsoft.com/en-us/download/details.aspx?id=17851
#
# To get the plugins work set ExecutionPolicy to Bypass via the command line:
#
#   powershell -ExecutionPolicy Bypass
#
# ... or set it permanent by running Powershell as Administrator, then:
#
#   Set-ExecutionPolicy -ExecutionPolicy Bypass
#
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.08.07 08:29 ==

#                    "PACKAGE-MANAGER" FOR POWERSHELL                     {{{1
# ============================================================================

Function Get-MyModule
{
  Param( [string] $name )
    if( -not (Get-Module -name $name) )
    {
      if( Get-Module -ListAvailable | Where-Object { $_.name -eq $name } )
      {
        Import-Module -name $name
        $true
      }
      else
      {
        $false
      }
    }
    else
    {
      $true
    }
}

if( -not (Get-Mymodule -name "PsGet") )
{
  (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

#                               PSREADLINE                                {{{1
# ============================================================================

if( -not (Get-Mymodule -name "PSReadLine") )
{
  Install-Module PSReadLine
}

# Bash-like editing.
Set-PSReadlineOption -EditMode Emacs

#                                POSH-GIT                                 {{{1
# ============================================================================
#
# Git commandline-completion and prompt string.

if( -not (Get-Mymodule -name "Posh-Git") )
{
  Install-Module Posh-Git
}

function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE
    Write-Host($pwd.ProviderPath) -nonewline
    Write-VcsStatus
    $global:LASTEXITCODE = $realLASTEXITCODE
    return "`n> "
}

Pop-Location
