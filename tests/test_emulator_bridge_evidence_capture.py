import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CAPTURE_PATH = ROOT / "rom_lab" / "bridge" / "capture_readonly_bridge_evidence.ps1"
PLAN_PATH = ROOT / "reports" / "emulator_bridge_evidence_capture_plan.md"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_evidence_capture_plan.ps1"


class EmulatorBridgeEvidenceCaptureTests(unittest.TestCase):
    def test_capture_plan_and_builder_exist(self):
        self.assertTrue(PLAN_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_capture_script_exists(self):
        self.assertTrue(CAPTURE_PATH.exists())

    def test_capture_script_delegates_to_contract_runner(self):
        text = CAPTURE_PATH.read_text(encoding="utf-8")
        self.assertIn("rom_lab/bridge/run_readonly_bridge.ps1", text)
        self.assertIn("run_readonly_bridge.ps1", text)
        self.assertIn("emulator_readonly_contract.json", text)
        self.assertIn("physical_device_allowed", text)
        self.assertIn("required_serial_pattern", text)

    def test_capture_script_is_emulator_only(self):
        text = CAPTURE_PATH.read_text(encoding="utf-8").lower()
        self.assertIn("emulator-only", text)
        self.assertIn("^emulator-[0-9]+$", text)
        self.assertIn("firmware_required = $false", text)
        self.assertIn("stock_image_acceptance = \"blocked\"", text)
        self.assertIn("recovery_anchor_acceptance = \"blocked\"", text)

    def test_capture_script_writes_json_and_markdown(self):
        text = CAPTURE_PATH.read_text(encoding="utf-8")
        self.assertIn("ConvertTo-Json", text)
        self.assertIn("Set-Content -Encoding UTF8 $JsonPath", text)
        self.assertIn("Set-Content -Encoding UTF8 $MarkdownPath", text)
        self.assertIn("rom_lab.emulator_bridge_evidence.v1", text)

    def test_capture_script_does_not_accept_target_escape_parameters(self):
        text = CAPTURE_PATH.read_text(encoding="utf-8").lower()
        forbidden_params = [
            "[string]$serial",
            "[string]$deviceserial",
            "[string]$device_serial",
            "[string]$target",
            "[string]$adb",
            "[string]$fastboot",
            "[switch]$flash",
            "[switch]$erase",
            "[switch]$wipe",
            "[switch]$mutate",
        ]
        for term in forbidden_params:
            self.assertNotIn(term, text)

    def test_capture_script_does_not_expose_forbidden_commands(self):
        text = CAPTURE_PATH.read_text(encoding="utf-8").lower()
        forbidden_commands = [
            "adb push",
            "adb pull",
            "adb install",
            "adb uninstall",
            "adb reboot",
            "adb sideload",
            "fastboot flash",
            "fastboot erase",
            "fastboot format",
            "fastboot update",
            "fastboot boot",
            "fastboot oem",
            "fastboot flashing",
            "dd ",
            "mkfs",
            "remount,rw",
        ]
        for term in forbidden_commands:
            self.assertNotIn(term, text)


if __name__ == "__main__":
    unittest.main()
