$ErrorActionPreference = "Stop"

$env:ANDROID_EMULATOR_USE_SYSTEM_LIBS = "1"
$env:QT_OPENGL = "software"
$env:ANDROID_SDK_ROOT = "C:\Android\Sdk"
$env:ANDROID_HOME = "C:\Android\Sdk"
$env:Path = "C:\Android\Sdk\platform-tools;C:\Android\Sdk\emulator;$env:Path"

& "C:\Android\Sdk\emulator\emulator.exe" `
  -avd forge_moto_one_hyper_lab_api35 `
  -no-snapshot `
  -no-boot-anim `
  -no-audio `
  -gpu guest `
  -feature -Vulkan `
  -no-metrics `
  -verbose
