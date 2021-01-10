$VMs = get-vm | select Name, State

Foreach ($VM in $VMs) {
    $key = "VM_state"
    $Name = "VM_Name=" + $VM.name
    $state = $VM.state | convertto-json
    $state3 = If ($state -eq 2) {
            '1'
            } Else { 
                '0'} 
    $Stateuse = "VM_state=" + $state3
    $VM_state = "VM_State"
    $postp =  "$VM_state,$Name $Stateuse"
    $post = Write-Output $postp


Invoke-WebRequest 'http://192.168.0.58:8086/write?db=dbname&u=user&p=pass' -method post  -body "$postp"
}
