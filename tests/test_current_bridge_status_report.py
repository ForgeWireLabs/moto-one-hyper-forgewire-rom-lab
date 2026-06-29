import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT = ROOT / "reports" / "current_bridge_status.md"
STATUS_SNAPSHOT = ROOT / "reports" / "emulator_bridge_status_snapshot.json"
READY_HANDOFF = ROOT / "reports" / "emulator_bridge_ready_handoff.md"


class CurrentBridgeStatusReportTests(unittest.TestCase):
    def test_current_bridge_status_report_exists(self):
        self.assertTrue(REPORT.exists())

    def test_current_bridge_status_report_references_committed_status_surfaces(self):
        text = REPORT.read_text(encoding="utf-8")
        self.assertIn("reports/emulator_bridge_status_snapshot.json", text)
        self.assertIn("reports/emulator_bridge_ready_handoff.md", text)
        self.assertIn("reports/emulator_bridge_latest_capture_outcome.md", text)
        self.assertTrue(STATUS_SNAPSHOT.exists())
        self.assertTrue(READY_HANDOFF.exists())

    def test_current_bridge_status_report_preserves_ready_state(self):
        text = REPORT.read_text(encoding="utf-8").lower()
        self.assertIn("| ready | true |", text)
        self.assertIn("| bridge status | ready |", text)
        self.assertIn("| target | emulator-only |", text)
        self.assertIn("| authority | readonly-emulator-inspection |", text)
        self.assertIn("readonly_bridge_20260629_153934_identity", text)

    def test_current_bridge_status_report_preserves_safety_gates(self):
        text = REPORT.read_text(encoding="utf-8").lower()
        self.assertIn("| physical phone touched | false |", text)
        self.assertIn("| firmware required | false |", text)
        self.assertIn("| stock image accepted | false |", text)
        self.assertIn("| recovery anchor accepted | false |", text)
        self.assertIn("| raw artifacts committed | false |", text)

    def test_current_bridge_status_report_does_not_expand_authority(self):
        text = REPORT.read_text(encoding="utf-8").lower()
        self.assertIn("emulator-only", text)
        self.assertIn("read-only", text)
        self.assertIn("does not authorize physical-device access", text)
        self.assertIn("does not authorize", text)
        self.assertIn("raw adb passthrough", text)
        self.assertIn("raw fastboot passthrough", text)
        self.assertIn("mutation", text)


if __name__ == "__main__":
    unittest.main()
