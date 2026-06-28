# Risk Register

| Risk | Impact | Mitigation | Status |
| --- | --- | --- | --- |
| No verified stock firmware package | Cannot safely patch or recover boot image | Continue exact firmware acquisition and hash verification | Open |
| No vendor blobs | True device ROM cannot boot hardware HAL stack | Extract from verified firmware or approved device path later | Open |
| No verified `def` device tree | Device-specific build is blocked | Research public trees and record exact commits | Open |
| Kernel mismatch | Boot failure or hardware instability | Match OEM/community SM6150 source carefully | Open |
| Dynamic partition mistake | Data loss or brick risk | Use emulator/GSI planning first; no hardware writes | Open |
| AVB/vbmeta mistake | Boot failure | Draft vbmeta strategy only after verified images | Open |
| Generic emulator overclaim | False confidence | Keep emulator and hardware evidence separate | Active mitigation |

