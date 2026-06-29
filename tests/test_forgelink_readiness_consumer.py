import json
import tempfile
import unittest
from pathlib import Path

from rom_lab.bridge.forgelink_readiness_consumer import read_readiness


ROOT = Path(__file__).resolve().parents[1]
STATUS_PATH = ROOT / "reports" / "emulator_bridge_status_snapshot.json"
HANDOFF_PATH = ROOT / "reports" / "emulator_bridge_ready_handoff.md"
MODULE_PATH = ROOT / "rom_lab" / "bridge" / "forgelink_readiness_consumer.py"


def write_snapshot(path: Path, **overrides):
    snapshot = {
        "schema": "rom_lab.emulator_bridge_status.v1",
        "generated_at_utc": "2026-06-29T15:39:36.3374315Z",
        "target": "emulator-only",
        "authority": "readonly-emulator-inspection",
        "status": "ready",
        "latest_capture": {
            "capture_id": "readonly_bridge_20260629_153934_identity",
            "mode": "identity",
            "exit_code": 0,
            "ok": True,
            "stdout_lines": 13,
            "stderr_lines": 0,
            "source_report": "reports/emulator_bridge_latest_capture_outcome.md",
        },
        "safety": {
            "physical_phone_touched": False,
            "firmware_required": False,
            "stock_image_accepted": False,
            "recovery_anchor_accepted": False,
            "raw_artifacts_committed": False,
        },
    }
    for key, value in overrides.items():
        if key in snapshot and isinstance(snapshot[key], dict) and isinstance(value, dict):
            snapshot[key].update(value)
        else:
            snapshot[key] = value
    path.write_text(json.dumps(snapshot), encoding="utf-8")


class ForgeLinkReadinessConsumerTests(unittest.TestCase):
    def test_module_exists(self):
        self.assertTrue(MODULE_PATH.exists())

    def test_current_ready_snapshot_is_consumed_as_ready(self):
        view = read_readiness(STATUS_PATH, HANDOFF_PATH)
        self.assertTrue(view.ok)
        self.assertEqual(view.status, "ready")
        self.assertEqual(view.target, "emulator-only")
        self.assertEqual(view.authority, "readonly-emulator-inspection")
        self.assertEqual(view.exit_code, 0)
        self.assertTrue(view.bridge_ok)
        self.assertFalse(view.physical_phone_touched)
        self.assertFalse(view.firmware_required)
        self.assertFalse(view.stock_image_accepted)
        self.assertFalse(view.recovery_anchor_accepted)
        self.assertFalse(view.raw_artifacts_committed)
        self.assertEqual(view.reason, "ready emulator-only readonly bridge status")

    def test_not_ready_snapshot_is_not_consumed_as_ready(self):
        with tempfile.TemporaryDirectory() as tmp:
            status = Path(tmp) / "status.json"
            handoff = Path(tmp) / "handoff.md"
            handoff.write_text("handoff", encoding="utf-8")
            write_snapshot(status, status="not_ready", latest_capture={"exit_code": 1, "ok": False})

            view = read_readiness(status, handoff)

        self.assertFalse(view.ok)
        self.assertEqual(view.reason, "bridge status is not ready")

    def test_physical_target_is_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            status = Path(tmp) / "status.json"
            handoff = Path(tmp) / "handoff.md"
            handoff.write_text("handoff", encoding="utf-8")
            write_snapshot(status, target="physical-device")

            view = read_readiness(status, handoff)

        self.assertFalse(view.ok)
        self.assertEqual(view.reason, "target is not emulator-only")

    def test_safety_flags_block_readiness(self):
        with tempfile.TemporaryDirectory() as tmp:
            status = Path(tmp) / "status.json"
            handoff = Path(tmp) / "handoff.md"
            handoff.write_text("handoff", encoding="utf-8")
            write_snapshot(status, safety={"physical_phone_touched": True})

            view = read_readiness(status, handoff)

        self.assertFalse(view.ok)
        self.assertEqual(view.reason, "safety flags do not permit readiness")
        self.assertTrue(view.physical_phone_touched)

    def test_missing_handoff_blocks_readiness(self):
        with tempfile.TemporaryDirectory() as tmp:
            status = Path(tmp) / "status.json"
            handoff = Path(tmp) / "missing.md"
            write_snapshot(status)

            view = read_readiness(status, handoff)

        self.assertFalse(view.ok)
        self.assertEqual(view.reason, "ready handoff report is missing")

    def test_consumer_does_not_invoke_bridge_or_raw_tools(self):
        text = MODULE_PATH.read_text(encoding="utf-8")
        self.assertNotIn("subprocess", text)
        self.assertNotIn("adb.exe", text)
        self.assertNotIn("capture_readonly_bridge_evidence", text)
        self.assertNotIn("run_readonly_bridge", text)
        self.assertIn("emulator_bridge_status_snapshot.json", text)
        self.assertIn("emulator_bridge_ready_handoff.md", text)


if __name__ == "__main__":
    unittest.main()
