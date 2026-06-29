import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = ROOT / "reports" / "emulator_bridge_latest_capture_outcome.md"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_latest_capture_outcome.ps1"


class EmulatorBridgeLatestCaptureOutcomeTests(unittest.TestCase):
    def test_latest_capture_outcome_report_and_builder_exist(self):
        self.assertTrue(REPORT_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_builder_reads_ignored_local_capture_json(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("readonly_bridge_*.json", text)
        self.assertIn("ConvertFrom-Json", text)
        self.assertIn("Sort-Object LastWriteTimeUtc -Descending", text)

    def test_builder_writes_commit_safe_report(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("reports\\emulator_bridge_latest_capture_outcome.md", text)
        self.assertIn("Raw artifacts committed", text)
        self.assertIn("Physical phone touched", text)
        self.assertIn("Firmware required", text)
        self.assertIn("Stock image accepted", text)
        self.assertIn("Recovery anchor accepted", text)

    def test_placeholder_report_is_safety_blocked(self):
        text = REPORT_PATH.read_text(encoding="utf-8").lower()
        self.assertIn("raw timestamped capture files remain local generated evidence", text)
        self.assertIn("raw artifacts committed | no", text)
        self.assertIn("physical phone touched | no", text)
        self.assertIn("firmware required | no", text)
        self.assertIn("stock image accepted | no", text)
        self.assertIn("recovery anchor accepted | no", text)


if __name__ == "__main__":
    unittest.main()
