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
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.08.31 13:48 ==

#                                 PLUGINS                                 {{{1
# ============================================================================

#                    "PACKAGE-MANAGER" FOR POWERSHELL                     {{{2
# ____________________________________________________________________________

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

#                               PSREADLINE                                {{{2
# ____________________________________________________________________________
#
# Bash-like behaviour.

if( -not (Get-Mymodule -name "PSReadLine") )
{
  Install-Module PSReadLine
}

# Bash-like editing.
Set-PSReadlineOption -EditMode Emacs

# Zsh-like history search.
Set-PSReadlineKeyHandler -Key UpArrow   -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key Ctrl+P    -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+N    -Function HistorySearchForward

#                                POSH-GIT                                 {{{2
# ____________________________________________________________________________
#
# Git commandline-completion and prompt string.

if( -not (Get-Mymodule -name "Posh-Git") )
{
  Install-Module Posh-Git
}

$global:GitPromptSettings = New-Object PSObject -Property @{
    DefaultForegroundColor    = $Host.UI.RawUI.ForegroundColor

    BeforeText                = '['
    BeforeForegroundColor     = [ConsoleColor]::Cyan
    BeforeBackgroundColor     = $Host.UI.RawUI.BackgroundColor
    DelimText                 = ' |'
    DelimForegroundColor      = [ConsoleColor]::Cyan
    DelimBackgroundColor      = $Host.UI.RawUI.BackgroundColor

    AfterText                 = ']'
    AfterForegroundColor      = [ConsoleColor]::Cyan
    AfterBackgroundColor      = $Host.UI.RawUI.BackgroundColor

    BranchForegroundColor       = [ConsoleColor]::Green
    BranchBackgroundColor       = $Host.UI.RawUI.BackgroundColor
    BranchAheadForegroundColor  = [ConsoleColor]::Green
    BranchAheadBackgroundColor  = $Host.UI.RawUI.BackgroundColor
    BranchBehindForegroundColor = [ConsoleColor]::Green
    BranchBehindBackgroundColor = $Host.UI.RawUI.BackgroundColor
    BranchBehindAndAheadForegroundColor = [ConsoleColor]::Green
    BranchBehindAndAheadBackgroundColor = $Host.UI.RawUI.BackgroundColor

    BeforeIndexText           = ""
    BeforeIndexForegroundColor= [ConsoleColor]::DarkGreen
    BeforeIndexForegroundBrightColor= [ConsoleColor]::Green
    BeforeIndexBackgroundColor= $Host.UI.RawUI.BackgroundColor

    IndexForegroundColor      = [ConsoleColor]::DarkGreen
    IndexForegroundBrightColor= [ConsoleColor]::Green
    IndexBackgroundColor      = $Host.UI.RawUI.BackgroundColor

    WorkingForegroundColor    = [ConsoleColor]::DarkRed
    WorkingForegroundBrightColor = [ConsoleColor]::Red
    WorkingBackgroundColor    = $Host.UI.RawUI.BackgroundColor

    UntrackedText             = ' !'
    UntrackedForegroundColor  = [ConsoleColor]::DarkRed
    UntrackedForegroundBrightColor  = [ConsoleColor]::Red
    UntrackedBackgroundColor  = $Host.UI.RawUI.BackgroundColor

    ShowStatusWhenZero        = $true

    AutoRefreshIndex          = $true

    EnablePromptStatus        = !$Global:GitMissing
    EnableFileStatus          = $false
    RepositoriesInWhichToDisableFileStatus = @( ) # Array of repository paths
    DescribeStyle             = ''

    Debug                     = $false

    BranchNameLimit           = 0
    TruncatedBranchSuffix     = '...'
}

#                                 PROMPT                                  {{{1
# ============================================================================

function Prompt {
  $realLASTEXITCODE = $LASTEXITCODE

  Write-Host ("`n[") -nonewline -foregroundcolor Cyan
  Write-Host (Get-Date -format HH:mm) -nonewline -foregroundcolor Gray
  Write-Host ("]") -nonewline -foregroundcolor Cyan
  # Posh-Git status
  Write-VcsStatus
  Write-Host (" $PWD") -nonewline -foregroundcolor white
  Write-Host ("`n$") -nonewline -foregroundcolor White

  $global:LASTEXITCODE = $realLASTEXITCODE
  return " ";
}
