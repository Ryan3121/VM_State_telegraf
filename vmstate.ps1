#Replace dbname, user and pass in the URL with username and password. If there is no auth then remove it so the URL looks like http://192.168.0.58:8086/write?db=telegraf .
#VM is on = 1 
#VM is off = 0

#Place this file in C:\Program Files\InfluxData\Telegraf\scripts\

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

Invoke-WebRequest 'http://192.168.0.58:8086/write?db=dbname&u=user&p=pass' -method post  -body "$postp"
}
