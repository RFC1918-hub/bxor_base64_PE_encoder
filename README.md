# bxor_base64_PE_encoder

Simple xor and base64 encoder for AV evasion.

Taking inspiration from https://github.com/chrismeistre/winpeas-encoder

Usage: 

```
./bxor_base64_PE_encoder.ps1 -url https://github.com/carlospolop/PEASS-ng/blob/master/winPEAS/winPEASexe/binaries/Obfuscated%20Releases/Dotfuscated/any/winPEASany.exe?raw=true -out winpeas.ps1 -namespace '[winPEAS.Program]::Main("")'
```
