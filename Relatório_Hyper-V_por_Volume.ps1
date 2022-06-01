Get-ClusterGroup -Cluster "Digite_Aqui_o_Nome_do_Cluster" | ? {$_.GroupType -eq 'VirtualMachine' } | Get-VM | `
% { $vhd = Get-VHD -ComputerName $_.ComputerName -VmId $_.VmId; $vhd | Add-Member -NotePropertyName "Name" -NotePropertyValue $_.Name; $vhd; } | `
Select-Object Name, @{label='Host Name';expression={$_.ComputerName}}, Path, VhdFormat, VhdType, @{label='Size On Physical Disk (GB)';expression={$_.FileSize/1gb –as [int]}}, `
@{label='Max Disk Size (GB)';expression={$_.Size/1gb –as [int]}}, @{label='Remaining Space (GB)';expression={($_.Size/1gb - $_.FileSize/1gb) –as [int]}} | `
Export-Csv -Path "C:\$($ClusterName)-VHDReport.csv" -NoTypeInformation


