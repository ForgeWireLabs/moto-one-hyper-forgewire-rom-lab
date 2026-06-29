import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REPORT = ROOT / "reports" / "forgelink_fabric_consumer_contract.md"
STATUS_SNAPSHOT = ROOT / "reports" / "emulator_bridge_status_snapshot.json"
READY_HANDOFF = ROOT / "reports" / "emulator_bridge_ready_handoff.md"
CURRENT_STATUS = ROOT / "reports" / "current_bridge_status.md"
LATEST_OUTCOME = ROOT / "reports" / "emulator_bridge_latest_capture_outcome.md"
CONSUMER = ROOT / "rom_lab" / "bridge" / "forgelink_readiness_consumer.py"


class ForgeLinkFabricConsumerContractReportTests(unittest.TestCase):
    def test_consumer_contract_report_exists(self):
        self.assertTrue(REPORT.exists())

    def test_consumer_contract_references_authoritative_committed_inputs(self):
        text = REPORT.read_text(encoding="utf-8")
        self.assertIn("reports/emulator_bridge_status_snapshot.json", text)
        self.assertIn("reports/emulator_bridge_ready_handoff.md", text)
        self.assertIn("reports/current_bridge_status.md", text)
        self.assertIn("reports/emulator_bridge_latest_capture_outcome.md", text)
        self.assertIn("rom_lab/bridge/forgelink_readiness_consumer.py", text)
        self.assertTrue(STATUS_SNAPSHOT.exists())
        self.assertTrue(READY_HANDOFF.exists())
        self.assertTrue(CURRENT_STATUS.exists())
        self.assertTrue(LATEST_OUTCOME.exists())
        self.assertTrue(CONSUMER.exists())

    def test_consumer_contract_defines_ready_criteria(self):
        text = REPORT.read_text(encoding="utf-8").lower()
        self.assertIn("`status` | `ready`", text)
        self.assertIn("`target` | `emulator-only`", text)
        self.assertIn("`authority` | `readonly-emulator-inspection`", text)
        self.assertIn("`latest_capture.exit_code` | `0`", text)
        self.assertIn("`latest_capture.ok` | `true`", text)
        self.assertIn("`safety.physical_phone_touched` | `false`", text)
        self.assertIn("`safety.firmware_required` | `false`", text)
        self.assertIn("`safety.stock_image_accepted` | `false`", text)
        self.assertIn("`safety.recovery_anchor_accepted` | `false`", text)
        self.assertIn("`safety.raw_artifacts_committed` | `false`", text)

    def test_consumer_contract_is_status_only_not_execution_authority(self):
        text = REPORT.read_text(encoding="utf-8").lower()
        self.assertIn("this consumer contract is not an execution contract", text)
        self.assertIn("does not authorize", text)
        self.assertIn("adb command passthrough", text)
        self.assertIn("fastboot command passthrough", text)
        self.assertIn("launching the bridge runner", text)
        self.assertIn("targeting a physical android serial", text)
        self.assertIn("mutation", text)

    def test_consumer_contract_requires_fail_closed_behavior(self):
        text = REPORT.read_text(encoding="utf-8").lower()
        self.assertIn("downstream consumers must fail closed", text)
        self.assertIn("status snapshot is missing or unreadable", text)
        self.assertIn("ready handoff is missing", text)
        self.assertIn("target is anything other than `emulator-only`", text)
        self.assertIn("authority is anything other than `readonly-emulator-inspection`", text)
        self.assertIn("any safety gate is true", text)


if __name__ == "__main__":
    unittest.main()
