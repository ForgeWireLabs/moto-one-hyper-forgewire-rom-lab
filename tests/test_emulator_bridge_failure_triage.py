import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = ROOT / "reports" / "emulator_bridge_failure_triage.md"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_failure_triage.ps1"


class EmulatorBridgeFailureTriageTests(unittest.TestCase):
    def test_failure_triage_report_and_builder_exist(self):
        self.assertTrue(REPORT_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_builder_reads_local_generated_capture_artifacts(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("readonly_bridge_*.json", text)
        self.assertIn("ChangeExtension", text)
        self.assertIn("ConvertFrom-Json", text)
        self.assertIn("Triage status", text)

    def test_builder_classifies_without_committing_raw_artifacts(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("missing_emulator", text)
        self.assertIn("runner_failure", text)
        self.assertIn("bridge_failure", text)
        self.assertIn("unknown_failure", text)
        self.assertIn("Raw artifacts committed", text)

    def test_report_keeps_triage_safety_boundaries(self):
        text = REPORT_PATH.read_text(encoding="utf-8").lower()
        self.assertIn("commit-safe triage surface", text)
        self.assertIn("raw timestamped capture files remain local-only", text)
        self.assertIn("physical phone touched | no", text)
        self.assertIn("firmware required | no", text)
        self.assertIn("stock image accepted | no", text)
        self.assertIn("recovery anchor accepted | no", text)
        self.assertIn("does not authorize", text)


if __name__ == "__main__":
    unittest.main()
