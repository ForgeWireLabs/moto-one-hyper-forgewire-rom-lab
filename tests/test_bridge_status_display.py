import io
import json
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path

from rom_lab.bridge.show_bridge_status import main, render_text
from rom_lab.bridge.forgelink_readiness_consumer import read_readiness


ROOT = Path(__file__).resolve().parents[1]
STATUS_COMMAND = ROOT / "rom_lab" / "bridge" / "show_bridge_status.py"
PS_WRAPPER = ROOT / "scripts" / "show_emulator_bridge_status.ps1"
STATUS_PATH = ROOT / "reports" / "emulator_bridge_status_snapshot.json"
HANDOFF_PATH = ROOT / "reports" / "emulator_bridge_ready_handoff.md"


def write_snapshot(path: Path, status="ready", target="emulator-only", ok=True, exit_code=0):
    snapshot = {
        "schema": "rom_lab.emulator_bridge_status.v1",
        "generated_at_utc": "2026-06-29T15:39:36.3374315Z",
        "target": target,
        "authority": "readonly-emulator-inspection",
        "status": status,
        "latest_capture": {
            "capture_id": "readonly_bridge_20260629_153934_identity",
            "mode": "identity",
            "exit_code": exit_code,
            "ok": ok,
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
    path.write_text(json.dumps(snapshot), encoding="utf-8")


class BridgeStatusDisplayTests(unittest.TestCase):
    def test_status_display_command_and_wrapper_exist(self):
        self.assertTrue(STATUS_COMMAND.exists())
        self.assertTrue(PS_WRAPPER.exists())

    def test_text_renderer_exposes_ready_status_and_boundary(self):
        view = read_readiness(STATUS_PATH, HANDOFF_PATH)
        text = render_text(view).lower()
        self.assertIn("emulator bridge readiness", text)
        self.assertIn("ready: true", text)
        self.assertIn("target: emulator-only", text)
        self.assertIn("physical phone touched: false", text)
        self.assertIn("does not authorize physical-device access", text)

    def test_json_output_is_machine_readable(self):
        output = io.StringIO()
        with redirect_stdout(output):
            exit_code = main(["--json"])
        data = json.loads(output.getvalue())
        self.assertEqual(exit_code, 0)
        self.assertTrue(data["ok"])
        self.assertEqual(data["target"], "emulator-only")
        self.assertFalse(data["physical_phone_touched"])
        self.assertFalse(data["raw_artifacts_committed"])

    def test_not_ready_status_returns_nonzero(self):
        with tempfile.TemporaryDirectory() as tmp:
            status = Path(tmp) / "status.json"
            handoff = Path(tmp) / "handoff.md"
            handoff.write_text("handoff", encoding="utf-8")
            write_snapshot(status, status="not_ready", ok=False, exit_code=1)
            output = io.StringIO()
            with redirect_stdout(output):
                exit_code = main(["--status-snapshot", str(status), "--ready-handoff", str(handoff)])
        self.assertEqual(exit_code, 1)
        self.assertIn("Ready: false", output.getvalue())

    def test_status_command_does_not_invoke_bridge_or_adb(self):
        text = STATUS_COMMAND.read_text(encoding="utf-8")
        self.assertNotIn("subprocess", text)
        self.assertNotIn("adb.exe", text)
        self.assertNotIn("capture_readonly_bridge_evidence", text)
        self.assertNotIn("run_readonly_bridge", text)
        self.assertIn("read_readiness", text)

    def test_powershell_wrapper_only_calls_status_command(self):
        text = PS_WRAPPER.read_text(encoding="utf-8")
        self.assertIn("show_bridge_status.py", text)
        self.assertNotIn("adb.exe", text)
        self.assertNotIn("capture_readonly_bridge_evidence", text)
        self.assertNotIn("run_readonly_bridge", text)


if __name__ == "__main__":
    unittest.main()
