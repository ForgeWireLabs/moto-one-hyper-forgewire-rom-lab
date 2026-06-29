import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
GITIGNORE_PATH = ROOT / ".gitignore"
STATUS_REPORT_PATH = ROOT / "reports" / "emulator_bridge_capture_status_report.md"
STATUS_BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_capture_status_report.ps1"
CAPTURE_DIR_README = ROOT / "rom_lab" / "reports" / "bridge_evidence" / "README.md"


class EmulatorBridgeCaptureStatusTests(unittest.TestCase):
    def test_status_report_and_builder_exist(self):
        self.assertTrue(STATUS_REPORT_PATH.exists())
        self.assertTrue(STATUS_BUILDER_PATH.exists())

    def test_capture_directory_readme_exists(self):
        self.assertTrue(CAPTURE_DIR_README.exists())

    def test_raw_generated_capture_artifacts_are_ignored(self):
        text = GITIGNORE_PATH.read_text(encoding="utf-8")
        self.assertIn("rom_lab/reports/bridge_evidence/*.json", text)
        self.assertIn("rom_lab/reports/bridge_evidence/*.md", text)
        self.assertIn("!rom_lab/reports/bridge_evidence/README.md", text)

    def test_status_report_keeps_raw_captures_local_by_default(self):
        text = STATUS_REPORT_PATH.read_text(encoding="utf-8").lower()
        self.assertIn("raw timestamped capture artifacts are local generated evidence by default", text)
        self.assertIn("raw capture artifacts committed by default | no", text)
        self.assertIn("commit summarized status reports by default", text)

    def test_status_report_keeps_safety_blocked(self):
        text = STATUS_REPORT_PATH.read_text(encoding="utf-8").lower()
        self.assertIn("physical phone required | no", text)
        self.assertIn("firmware required | no", text)
        self.assertIn("stock image accepted | no", text)
        self.assertIn("recovery anchor accepted | no", text)
        self.assertIn("does not authorize", text)


if __name__ == "__main__":
    unittest.main()
