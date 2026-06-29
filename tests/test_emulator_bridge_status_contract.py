import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SCHEMA_PATH = ROOT / "rom_lab" / "bridge" / "emulator_bridge_status_schema.json"
CONTRACT_PATH = ROOT / "reports" / "emulator_bridge_status_contract.md"
SNAPSHOT_PATH = ROOT / "reports" / "emulator_bridge_status_snapshot.json"
BUILDER_PATH = ROOT / "scripts" / "build_emulator_bridge_status_snapshot.ps1"


class EmulatorBridgeStatusContractTests(unittest.TestCase):
    def test_status_schema_contract_snapshot_and_builder_exist(self):
        self.assertTrue(SCHEMA_PATH.exists())
        self.assertTrue(CONTRACT_PATH.exists())
        self.assertTrue(SNAPSHOT_PATH.exists())
        self.assertTrue(BUILDER_PATH.exists())

    def test_schema_declares_readonly_emulator_status_surface(self):
        schema = json.loads(SCHEMA_PATH.read_text(encoding="utf-8"))
        self.assertEqual(schema["schema"], "rom_lab.emulator_bridge_status_schema.v1")
        self.assertEqual(schema["target"]["required_value"], "emulator-only")
        self.assertFalse(schema["target"]["physical_device_allowed"])
        self.assertEqual(schema["authority"]["allowed_value"], "readonly-emulator-inspection")
        self.assertFalse(schema["authority"]["raw_command_passthrough_allowed"])
        self.assertIn("not_ready", schema["allowed_status_values"])

    def test_snapshot_placeholder_is_safety_blocked_by_default(self):
        snapshot = json.loads(SNAPSHOT_PATH.read_text(encoding="utf-8"))
        self.assertEqual(snapshot["schema"], "rom_lab.emulator_bridge_status.v1")
        self.assertEqual(snapshot["target"], "emulator-only")
        self.assertEqual(snapshot["authority"], "readonly-emulator-inspection")
        self.assertIn(snapshot["status"], {"unknown", "not_ready", "blocked", "ready"})
        self.assertFalse(snapshot["safety"]["physical_phone_touched"])
        self.assertFalse(snapshot["safety"]["firmware_required"])
        self.assertFalse(snapshot["safety"]["stock_image_accepted"])
        self.assertFalse(snapshot["safety"]["recovery_anchor_accepted"])
        self.assertFalse(snapshot["safety"]["raw_artifacts_committed"])

    def test_contract_maps_non_success_capture_to_not_ready(self):
        text = CONTRACT_PATH.read_text(encoding="utf-8").lower()
        self.assertIn("non-success bridge result", text)
        self.assertIn('"status": "not_ready"', text)
        self.assertIn("status surface, not a control surface", text)
        self.assertIn("physical_phone_touched | false", text)
        self.assertIn("firmware_required | false", text)
        self.assertIn("raw_artifacts_committed | false", text)

    def test_builder_reads_sanitized_outcome_report_only(self):
        text = BUILDER_PATH.read_text(encoding="utf-8")
        self.assertIn("reports\\emulator_bridge_latest_capture_outcome.md", text)
        self.assertIn("Read-OutcomeField", text)
        self.assertIn("Bridge result OK", text)
        self.assertIn("status = \"not_ready\"", text)
        self.assertIn("ConvertTo-Json", text)
        self.assertNotIn("readonly_bridge_*.json", text)


if __name__ == "__main__":
    unittest.main()
