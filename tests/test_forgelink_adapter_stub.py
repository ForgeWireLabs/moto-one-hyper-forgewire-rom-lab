import unittest
from unittest.mock import Mock

from rom_lab.bridge.forgelink_adapter_stub import (
    dispatch_request,
    forbidden_fields,
    normalize_request,
)


class ForgeLinkAdapterStubTests(unittest.TestCase):
    def test_forbidden_fields_are_loaded_from_protocol(self):
        fields = forbidden_fields()
        self.assertIn("serial", fields)
        self.assertIn("device_serial", fields)
        self.assertIn("adb_args", fields)

    def test_normalize_accepts_mode(self):
        request = normalize_request({"mode": "identity"})
        self.assertEqual(request.mode, "identity")
        self.assertEqual(request.wrapper_payload["mode"], "identity")
        self.assertEqual(request.wrapper_payload["target"] if "target" in request.wrapper_payload else "emulator-only", "emulator-only")

    def test_normalize_accepts_operation_alias(self):
        request = normalize_request({"operation": "identity"})
        self.assertEqual(request.mode, "identity")
        self.assertEqual(request.wrapper_payload["mode"], "identity")

    def test_normalize_accepts_params_object(self):
        request = normalize_request(
            {
                "operation": "prop-read",
                "params": {
                    "PropName": "ro.product.device",
                },
            }
        )
        self.assertEqual(request.mode, "prop-read")
        self.assertEqual(request.wrapper_payload["PropName"], "ro.product.device")

    def test_normalize_rejects_forbidden_top_level_field(self):
        with self.assertRaises(ValueError) as ctx:
            normalize_request({"mode": "identity", "serial": "ZY227JQC67"})
        self.assertIn("Forbidden adapter fields", str(ctx.exception))

    def test_normalize_rejects_forbidden_param_field(self):
        with self.assertRaises(ValueError) as ctx:
            normalize_request(
                {
                    "mode": "identity",
                    "params": {
                        "device_serial": "ZY227JQC67",
                    },
                }
            )
        self.assertIn("Forbidden adapter parameter fields", str(ctx.exception))

    def test_normalize_rejects_unknown_top_level_field(self):
        with self.assertRaises(ValueError) as ctx:
            normalize_request({"mode": "identity", "unexpected": True})
        self.assertIn("Unknown adapter fields", str(ctx.exception))

    def test_normalize_rejects_unknown_param_field(self):
        with self.assertRaises(ValueError) as ctx:
            normalize_request({"mode": "identity", "params": {"unexpected": True}})
        self.assertIn("Unknown adapter parameter fields", str(ctx.exception))

    def test_normalize_rejects_unknown_mode(self):
        with self.assertRaises(ValueError) as ctx:
            normalize_request({"mode": "not-a-mode"})
        self.assertIn("Mode is not allowed", str(ctx.exception))

    def test_dispatch_delegates_to_runner_without_live_emulator(self):
        runner = Mock(
            return_value={
                "ok": True,
                "mode": "identity",
                "target": "emulator-only",
                "stdout": "ok",
                "stderr": "",
                "exit_code": 0,
            }
        )

        response = dispatch_request({"mode": "identity"}, runner=runner)

        self.assertTrue(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        runner.assert_called_once()
        called_payload = runner.call_args.args[0]
        self.assertEqual(called_payload["mode"], "identity")

    def test_dispatch_returns_structured_validation_error(self):
        response = dispatch_request({"mode": "identity", "serial": "ZY227JQC67"})
        self.assertFalse(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["exit_code"], 2)
        self.assertIn("Forbidden adapter fields", response["stderr"])

    def test_dispatch_preserves_request_id_when_present(self):
        runner = Mock(
            return_value={
                "ok": True,
                "mode": "identity",
                "target": "emulator-only",
                "stdout": "ok",
                "stderr": "",
                "exit_code": 0,
            }
        )

        response = dispatch_request(
            {
                "request_id": "abc-123",
                "operation": "identity",
            },
            runner=runner,
        )

        self.assertEqual(response["request_id"], "abc-123")


if __name__ == "__main__":
    unittest.main()
