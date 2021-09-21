# bxor_base64_PE_encoder

Simple xor and base64 encoder for AV evasion

Taking inspiration from https://github.com/chrismeistre/winpeas-encoder

**Usage:**

**URL:**

./bxor_base64_PE_encoder.ps1 -url {URL} -out {OUTFILE} -namespace '{NAMESPACE}'

**Binary:**

./bxor_base64_PE_encoder.ps1 -binary {binary} -out {OUTFILE} -namespace '{NAMESPACE}'

**Namespace example:** 

```
[winPEAS.Program]::Main("")
```
