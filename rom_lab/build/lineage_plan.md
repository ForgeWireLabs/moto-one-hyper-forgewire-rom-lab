# LineageOS Build Plan

## Host requirements

Expect a Linux build host with:

- 16 CPU threads preferred
- 32 GB RAM minimum, 64 GB preferred
- 300 GB or more free disk for source, ccache, and outputs
- fast SSD storage
- Python, Java, Git, repo, and standard Android build dependencies

A local laptop may be insufficient if disk, RAM, or Linux virtualization support
is limited. A dedicated Linux workstation, cloud VM with nested virtualization,
or attached build machine is the safer option for full source builds.

## Branch options

- Modern LineageOS branch: preferred for custom-ROM user experience.
- Older branch matching stock Android 11 era: potentially easier for initial
  device bring-up if community device trees are old.
- GSI-first: use an existing generic image or generic target to validate the
  lab before syncing a full source tree.

## Strategy

1. Boot a generic Android image in emulator/Cuttlefish.
2. Acquire or build a GSI and test generic boot behavior.
3. Research and verify `def` device tree, common tree, kernel, and vendor blob
   sources.
4. Only after source pieces are real, attempt a `def` build.
5. Only after a build exists and emulator/GSI evidence is recorded, discuss any
   hardware test gate.

## Repository rule

Do not commit Android source checkouts, `out/`, `.repo/`, `.img`, `.zip`,
firmware packages, vendor blobs, or phone dumps.

