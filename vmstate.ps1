#Replace dbname with your DB name
#VM is on = 1 
#VM is off = 0

#Now also gets the uptime of a VM too

#Place this file in C:\Program Files\InfluxData\Telegraf\scripts\

$VMs = get-vm | select Name, State, Uptime

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
    $uptime = $VM.uptime | select "totalmilliseconds" -ExpandProperty "TotalMilliseconds"
    $uptimeuse = "VM_Uptime=" + $uptime
    $postp =  "$VM_state,$Name $Stateuse,$uptimeuse"
    $post = Write-Output $postp


Invoke-WebRequest 'http://192.168.0.58:8086/write?db=telegraf' -method post  -body "$postp"
}
