# conemu /cmd "powershell -ExecutionPolicy Bypass"
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.25 18:05 ==

#                        IMPORT / INSTALL MODULES                         {{{1
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

# "Package-manager" for powershell.
if( -not (Get-Mymodule -name "PsGet") )
{
  (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

# Git commandline-completion and prompt string.
if( -not (Get-Mymodule -name "Posh-Git") )
{
  Install-Module Posh-Git
}
