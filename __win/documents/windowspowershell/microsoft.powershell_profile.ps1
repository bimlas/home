# conemu /cmd "powershell -ExecutionPolicy Bypass"
# ========== BimbaLaszlo(.github.io|gmail.com) =========== 2014.08.25 18:05 ==

#                              GET-MYMODULE                               {{{1
# ============================================================================

Function Get-MyModule
{
  Param( [string] $name )
    if( -not (Get-Module -name $name) )
    {
      if( Get-Module -ListAvailable | Where-Object { $_.name -eq $name } )
      {
        Import-Module -Name $name
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

#                                  MAIN                                   {{{1
# ============================================================================

if( -not (Get-Mymodule -name "PsGet") )
{
  (new-object Net.WebClient).DownloadString("http://psget.net/GetPsGet.ps1") | iex
}

if( -not (Get-Mymodule -name "posh-git") )
{
  Install-Module Posh-Git
}

# Load posh-git example profile
. "$env:userprofile\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1"
