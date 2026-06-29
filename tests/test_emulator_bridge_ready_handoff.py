import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT_PATH = ROOT / "reports" / "emulator_bridge_ready_handoff.md"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_ready_handoff.ps1"


class EmulatorBridgeReadyHandoffTests(unittest.TestCase):
    def test_ready_handoff_report_and_builder_exist(self):
        self.assertTrue(REPORT_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_builder_reads_ready_status_surfaces(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("emulator_bridge_status_snapshot.json", text)
        self.assertIn("emulator_bridge_failure_triage.md", text)
        self.assertIn("emulator_bridge_runner_diagnostic.md", text)
        self.assertIn("emulator_bridge_invocation_diagnostic.md", text)
        self.assertIn("Handoff status", text)
        self.assertIn("Write-Utf8NoBom", text)

    def test_builder_preserves_safety_gates(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("physical_phone_touched", text)
        self.assertIn("firmware_required", text)
        self.assertIn("stock_image_accepted", text)
        self.assertIn("recovery_anchor_accepted", text)
        self.assertIn("raw_artifacts_committed", text)
        self.assertIn("not_ready", text)

    def test_report_defines_ready_handoff_boundary(self):
        text = REPORT_PATH.read_text(encoding="utf-8-sig").lower()
        self.assertIn("emulator bridge ready handoff", text)
        self.assertIn("ready handoff summary", text)
        self.assertIn("what is proven", text)
        self.assertIn("what is not proven", text)
        self.assertIn("consumer meaning", text)
        self.assertIn("emulator-only", text)
        self.assertIn("raw artifacts committed", text)


if __name__ == "__main__":
    unittest.main()
