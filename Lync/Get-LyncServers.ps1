﻿function Get-LyncServers {
    # Short function to pull out some of the general Lync servers in a deployment
    $DatabaseServers = @()
    $FrontEndServers = @()
    $EdgeServers = @()
    $PChatServers = @()
    $Pools = get-cspool 
    Foreach ($Pool in $Pools) {
        switch -wildcard ($Pool.Services) {
            '*Database:*' {
                $DatabaseServers += $Pool.Computers
            }
            'EdgeServer:*' {
                $EdgeServers += $Pool.Computers
            }
            'WitnessStore:*' {
                $DatabaseServers += $Pool.Computers
            }
            'Registrar:*' {
                $FrontEndServers += $Pool.Computers
            }
            'PersistentChatServer:*' {
                $PChatServers += $Pool.Computers
            }
        }
    }
    $PChatServers | Select -Unique | %{New-Object psobject -Property @{'Type' = 'PersistentChat'; 'Server' = $_}}
    $FrontEndServers | Select -Unique | %{New-Object psobject -Property @{'Type' = 'FrontEnd'; 'Server' = $_}}
    $EdgeServers | Select -Unique | %{New-Object psobject -Property @{'Type' = 'Edge'; 'Server' = $_}}
    $DatabaseServers | Select -Unique | %{New-Object psobject -Property @{'Type' = 'Database'; 'Server' = $_}}
}
