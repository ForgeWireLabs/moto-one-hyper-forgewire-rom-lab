import unittest
from pathlib import Path

from rom_lab.bridge.forgelink_adapter_stub import dispatch_request, normalize_request


ROOT = Path(__file__).resolve().parents[1]
DOC = ROOT / "docs" / "forgelink_bridge_request_response_examples.md"
ADAPTER = ROOT / "rom_lab" / "bridge" / "forgelink_adapter_stub.py"


def fake_runner(payload):
    return {
        "ok": True,
        "mode": payload["mode"],
        "target": "emulator-only",
        "stdout": "sample output",
        "stderr": "",
        "exit_code": 0,
    }


class ForgeLinkBridgeRequestResponseExamplesTests(unittest.TestCase):
    def test_examples_doc_exists(self):
        self.assertTrue(DOC.exists())

    def test_examples_doc_preserves_emulator_only_boundary(self):
        text = DOC.read_text(encoding="utf-8").lower()
        self.assertIn("emulator-only", text)
        self.assertIn("named read-only bridge modes only", text)
        self.assertIn("does not accept", text)
        self.assertIn("physical device serials", text)
        self.assertIn("raw adb arguments", text)
        self.assertIn("raw shell commands", text)
        self.assertIn("fastboot arguments", text)
        self.assertIn("mutation", text)

    def test_identity_example_matches_adapter_behavior(self):
        response = dispatch_request(
            {"request_id": "fw-demo-identity-001", "mode": "identity"},
            runner=fake_runner,
        )
        self.assertTrue(response["ok"])
        self.assertEqual(response["mode"], "identity")
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["request_id"], "fw-demo-identity-001")

    def test_operation_alias_example_matches_adapter_behavior(self):
        response = dispatch_request(
            {"request_id": "fw-demo-packages-001", "operation": "packages"},
            runner=fake_runner,
        )
        self.assertTrue(response["ok"])
        self.assertEqual(response["mode"], "packages")
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["request_id"], "fw-demo-packages-001")

    def test_property_params_example_normalizes_to_wrapper_payload(self):
        request = normalize_request(
            {
                "request_id": "fw-demo-prop-001",
                "mode": "prop-read",
                "params": {"PropName": "ro.build.fingerprint"},
            }
        )
        self.assertEqual(request.mode, "prop-read")
        self.assertEqual(request.request_id, "fw-demo-prop-001")
        self.assertEqual(request.wrapper_payload["PropName"], "ro.build.fingerprint")

    def test_logcat_params_example_normalizes_to_bounded_payload(self):
        request = normalize_request(
            {
                "request_id": "fw-demo-logcat-001",
                "mode": "logcat-tail",
                "params": {"LogLines": 100},
            }
        )
        self.assertEqual(request.mode, "logcat-tail")
        self.assertEqual(request.wrapper_payload["LogLines"], 100)

    def test_physical_serial_example_is_rejected_before_runner(self):
        response = dispatch_request(
            {
                "request_id": "fw-demo-reject-serial-001",
                "mode": "identity",
                "serial": "ZY22EXAMPLE",
            },
            runner=fake_runner,
        )
        self.assertFalse(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["exit_code"], 2)
        self.assertIn("Forbidden adapter fields: serial", response["stderr"])

    def test_raw_command_example_is_rejected_before_runner(self):
        response = dispatch_request(
            {
                "request_id": "fw-demo-reject-command-001",
                "mode": "identity",
                "command": "shell getprop",
            },
            runner=fake_runner,
        )
        self.assertFalse(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["exit_code"], 2)
        self.assertIn("Forbidden adapter fields: command", response["stderr"])

    def test_adapter_still_does_not_expose_subprocess_or_raw_tools(self):
        text = ADAPTER.read_text(encoding="utf-8")
        self.assertNotIn("subprocess", text)
        self.assertNotIn("adb.exe", text)
        self.assertNotIn("fastboot", text.lower().replace("raw fastboot", ""))


if __name__ == "__main__":
    unittest.main()
