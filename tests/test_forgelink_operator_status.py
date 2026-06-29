import unittest
from datetime import datetime
from pathlib import Path

from rom_lab.bridge.forgelink_adapter_stub import dispatch_request, normalize_request


ROOT = Path(__file__).resolve().parents[1]
OPERATIONS = ROOT / "rom_lab" / "bridge" / "emulator_readonly_operations.json"
CONTRACT = ROOT / "rom_lab" / "bridge" / "emulator_readonly_contract.json"
RUNNER = ROOT / "rom_lab" / "bridge" / "run_readonly_bridge.ps1"
LOW_LEVEL_RUNNER = ROOT / "rom_lab" / "scripts" / "invoke_emulator_adb_readonly.ps1"


SAMPLE_OPERATOR_STDOUT = """
Bridge contract: C:\\Projects\\moto-one-hyper\\rom_lab\\bridge\\emulator_readonly_contract.json
Bridge mode: operator-status
Bridge target: emulator only

Target emulator serial: emulator-5554

## devices
List of devices attached
emulator-5554 device

## boot
1

## identity
ro.build.version.release=15
ro.build.version.sdk=35
ro.product.cpu.abi=x86_64
ro.product.model=sdk_gphone64_x86_64
ro.hardware=ranchu
ro.build.fingerprint=google/sdk_gphone64_x86_64/emu64x:15/AP3A/example:userdebug/dev-keys

## packages
package:android
package:com.android.settings
package:com.forgelink.demo

## activity-list
0
ACTIVITY com.android.launcher3/.uioverrides.QuickstepLauncher 123 pid=456

## storage-read
/dev/block/dm-1  4.9G  2.1G  2.8G  43% /system
/data           8.0G  1.0G  7.0G  13% /data

## network-read
1: lo: <LOOPBACK,UP>
2: wlan0: <BROADCAST,MULTICAST,UP>
10.0.2.3
"""


def fake_operator_runner(payload):
    return {
        "ok": True,
        "mode": payload["mode"],
        "target": "emulator-only",
        "stdout": SAMPLE_OPERATOR_STDOUT,
        "stderr": "",
        "exit_code": 0,
    }


def failing_operator_runner(payload):
    return {
        "ok": False,
        "mode": payload["mode"],
        "target": "emulator-only",
        "stdout": "",
        "stderr": "No running emulator device found.",
        "exit_code": 1,
    }


class ForgeLinkOperatorStatusTests(unittest.TestCase):
    def test_operator_status_mode_is_registered(self):
        operations_text = OPERATIONS.read_text(encoding="utf-8")
        contract_text = CONTRACT.read_text(encoding="utf-8")
        runner_text = RUNNER.read_text(encoding="utf-8")
        low_level_runner_text = LOW_LEVEL_RUNNER.read_text(encoding="utf-8")

        self.assertIn('"mode": "operator-status"', operations_text)
        self.assertIn('"operator-status"', contract_text)
        self.assertIn('"operator-status"', runner_text)
        self.assertIn('"operator-status"', low_level_runner_text)

    def test_operator_status_normalizes_as_allowed_mode(self):
        request = normalize_request({"mode": "operator-status", "request_id": "op-001"})
        self.assertEqual(request.mode, "operator-status")
        self.assertEqual(request.request_id, "op-001")
        self.assertEqual(request.wrapper_payload["mode"], "operator-status")

    def test_operator_status_response_matches_forgelink_contract(self):
        response = dispatch_request(
            {"mode": "operator-status", "request_id": "op-001"},
            runner=fake_operator_runner,
        )

        self.assertTrue(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["authority"], "readonly-emulator-inspection")
        self.assertEqual(response["mode"], "operator-status")
        self.assertEqual(response["request_id"], "op-001")
        self.assertEqual(response["bridge_version"], "rom_lab.forgelink_operator_status.v1")
        self.assertIn("generated_at", response)
        datetime.fromisoformat(response["generated_at"].replace("Z", "+00:00"))

        self.assertEqual(response["device"]["android_release"], "15")
        self.assertEqual(response["device"]["sdk"], "35")
        self.assertEqual(response["device"]["model"], "sdk_gphone64_x86_64")
        self.assertEqual(response["device"]["hardware"], "ranchu")
        self.assertIn("sdk_gphone64_x86_64", response["device"]["fingerprint"])
        self.assertEqual(response["boot"], {"completed": True})
        self.assertEqual(response["packages"]["count"], 3)
        self.assertIn("sanitized line", response["network"]["summary"])
        self.assertIn("sanitized line", response["storage"]["summary"])
        self.assertEqual(response["activity"]["current_user"], "0")
        self.assertIn("ACTIVITY", response["activity"]["top_activity"])

    def test_operator_status_failure_shape_is_degraded_not_crashing(self):
        response = dispatch_request(
            {"mode": "operator-status", "request_id": "op-fail"},
            runner=failing_operator_runner,
        )

        self.assertFalse(response["ok"])
        self.assertEqual(response["mode"], "operator-status")
        self.assertEqual(response["request_id"], "op-fail")
        self.assertEqual(response["error"], "No running emulator device found.")

    def test_operator_status_rejects_physical_targeting_fields(self):
        response = dispatch_request(
            {"mode": "operator-status", "request_id": "op-bad", "serial": "ZY22EXAMPLE"},
            runner=fake_operator_runner,
        )

        self.assertFalse(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["exit_code"], 2)
        self.assertIn("Forbidden adapter fields: serial", response["stderr"])

    def test_operator_status_does_not_add_new_raw_command_surface(self):
        adapter_text = (ROOT / "rom_lab" / "bridge" / "forgelink_adapter_stub.py").read_text(encoding="utf-8")
        self.assertNotIn("adb.exe", adapter_text)
        self.assertNotIn("fastboot.exe", adapter_text.lower())
        self.assertNotIn("shell getprop", adapter_text)


if __name__ == "__main__":
    unittest.main()
