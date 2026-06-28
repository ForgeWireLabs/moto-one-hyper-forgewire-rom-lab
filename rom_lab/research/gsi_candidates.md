# GSI Candidates

GSI work is the practical first track because it can validate a modern Android
userspace image without claiming the Motorola One Hyper port is complete.

## Candidate classes

- Official AOSP GSI: best for conformance-oriented baseline testing.
- LineageOS GSI: practical custom-ROM experience test, community-built.
- Other Treble GSIs: research-only until provenance, hashes, and device reports
  are recorded.

## Required checks before any package is used

- architecture: ARM64
- partition layout and dynamic super implications
- Android version and security patch
- AVB/vbmeta instructions
- exact package hash
- source/release provenance
- whether the image is intended for emulator-only, GSI test, or device flash

## Safety boundary

Downloading or booting a generic image in an emulator is allowed. Flashing a GSI
or any vbmeta/system/vendor/super image to the physical phone is blocked until
Jeremy explicitly approves the exact action.

