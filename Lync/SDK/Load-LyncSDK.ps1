﻿function Load-LyncSDK {
    [CmdLetBinding()]
    param(
        [Parameter(Position=0, HelpMessage='Full SDK location (ie C:\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.dll). If not defined then typical locations will be attempted.')]
        [string]$SDKLocation
    )
    $LyncSDKLoaded = $false
    if (-not (Get-Module -Name Microsoft.Lync.Model)) {
        if (($SDKLocation -eq $null) -or ($SDKLocation -eq '')) {
            try { # Try loading the 32 bit version first
                Import-Module -Name (Join-Path -Path ${env:ProgramFiles(x86)} -ChildPath "Microsoft Office\Office15\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.dll") -ErrorAction Stop
                $LyncSDKLoaded = $true
            }
            catch {}
            try { # Otherwise try the 64 bit version
                Import-Module -Name (Join-Path -Path ${env:ProgramFiles} -ChildPath "Microsoft Office\Office15\LyncSDK\Assemblies\Desktop\Microsoft.Lync.Model.dll") -ErrorAction Stop
                $LyncSDKLoaded = $true
            }
            catch {}
        }
        else {
            try {
                Import-Module -Name $SDKLocation -ErrorAction Stop
                $LyncSDKLoaded = $true
            }
            catch {}
        }
    }
    else {
        $LyncSDKLoaded = $true
    }
    return $LyncSDKLoaded
}
