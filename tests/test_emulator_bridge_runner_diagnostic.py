import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = ROOT / "reports" / "emulator_bridge_runner_diagnostic.md"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_runner_diagnostic.ps1"


class EmulatorBridgeRunnerDiagnosticTests(unittest.TestCase):
    def test_runner_diagnostic_report_and_builder_exist(self):
        self.assertTrue(REPORT_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_builder_checks_runner_prerequisites(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("run_readonly_bridge.ps1", text)
        self.assertIn("emulator_readonly_contract.json", text)
        self.assertIn("readonly_bridge", text)
        self.assertIn("required_serial_pattern", text)
        self.assertIn("runner_prereq_failed", text)

    def test_builder_summarizes_latest_capture_state(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("readonly_bridge_*.json", text)
        self.assertIn("Latest capture ID", text)
        self.assertIn("Latest capture exit code", text)
        self.assertIn("runner_capture_failed", text)
        self.assertIn("Write-Utf8NoBom", text)

    def test_report_preserves_boundary(self):
        text = REPORT_PATH.read_text(encoding="utf-8-sig").lower()
        self.assertIn("durable", text)
        self.assertIn("emulator-only readonly bridge runner", text)
        self.assertIn("diagnostic status", text)
        self.assertIn("runner_capture_failed", text)
        self.assertIn("emulator-only, read-only", text)


if __name__ == "__main__":
    unittest.main()
