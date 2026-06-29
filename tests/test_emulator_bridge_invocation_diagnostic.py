import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = ROOT / "reports" / "emulator_bridge_invocation_diagnostic.md"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_invocation_diagnostic.ps1"


class EmulatorBridgeInvocationDiagnosticTests(unittest.TestCase):
    def test_invocation_diagnostic_report_and_builder_exist(self):
        self.assertTrue(REPORT_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_builder_checks_invocation_script_structure(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("invoke_emulator_adb_readonly.ps1", text)
        self.assertIn("Get-EmulatorSerial", text)
        self.assertIn("ro.build.fingerprint", text)
        self.assertIn("Invoke-EmulatorAdb", text)
        self.assertIn("invocation_prereq_failed", text)

    def test_builder_summarizes_latest_capture_and_status(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("readonly_bridge_*.json", text)
        self.assertIn("Latest capture exit code", text)
        self.assertIn("emulator_visibility_check_needed", text)
        self.assertIn("adb_path_check_needed", text)
        self.assertIn("Write-Utf8NoBom", text)

    def test_report_preserves_boundary(self):
        text = REPORT_PATH.read_text(encoding="utf-8-sig").lower()
        self.assertIn("readonly emulator bridge invocation layer", text)
        self.assertIn("diagnostic statuses", text)
        self.assertIn("emulator_visibility_check_needed", text)
        self.assertIn("adb_path_check_needed", text)
        self.assertIn("emulator-only, read-only", text)


if __name__ == "__main__":
    unittest.main()
