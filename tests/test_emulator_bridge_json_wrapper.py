import json
import unittest
from pathlib import Path
from unittest.mock import Mock, patch

from rom_lab.bridge.emulator_readonly_json_wrapper import (
    ROOT,
    BridgeRequest,
    build_runner_command,
    empty_response,
    run_request,
    validate_request,
)


class EmulatorBridgeJsonWrapperTests(unittest.TestCase):
    def test_validate_request_accepts_known_mode(self):
        request = validate_request({"mode": "identity"})
        self.assertEqual(request.mode, "identity")
        self.assertEqual(request.prop_name, "ro.build.fingerprint")
        self.assertEqual(request.settings_namespace, "global")
        self.assertEqual(request.settings_key, "")
        self.assertEqual(request.log_lines, 100)

    def test_validate_request_rejects_missing_mode(self):
        with self.assertRaises(ValueError) as ctx:
            validate_request({})
        self.assertIn("Missing required fields", str(ctx.exception))

    def test_validate_request_rejects_unknown_mode(self):
        with self.assertRaises(ValueError) as ctx:
            validate_request({"mode": "not-a-mode"})
        self.assertIn("Mode is not allowed", str(ctx.exception))

    def test_validate_request_rejects_forbidden_fields(self):
        with self.assertRaises(ValueError) as ctx:
            validate_request({"mode": "identity", "serial": "ZY227JQC67"})
        self.assertIn("Forbidden request fields", str(ctx.exception))
        self.assertIn("serial", str(ctx.exception))

    def test_validate_request_rejects_bad_settings_namespace(self):
        with self.assertRaises(ValueError) as ctx:
            validate_request({"mode": "settings-read", "SettingsNamespace": "bad"})
        self.assertIn("SettingsNamespace is not allowed", str(ctx.exception))

    def test_validate_request_rejects_bad_log_lines(self):
        with self.assertRaises(ValueError) as ctx:
            validate_request({"mode": "logcat-tail", "LogLines": 5000})
        self.assertIn("LogLines must be between 1 and 1000", str(ctx.exception))

    def test_build_runner_command_targets_contract_gated_runner(self):
        command = build_runner_command(BridgeRequest(mode="identity"))
        joined = " ".join(command)
        self.assertIn("powershell", command[0])
        self.assertIn("run_readonly_bridge.ps1", joined)
        self.assertIn("-Mode", command)
        self.assertIn("identity", command)
        self.assertNotIn("ZY227JQC67", joined)

    def test_build_runner_command_includes_optional_settings_key(self):
        command = build_runner_command(
            BridgeRequest(
                mode="settings-read",
                settings_namespace="global",
                settings_key="airplane_mode_on",
            )
        )
        self.assertIn("-SettingsKey", command)
        self.assertIn("airplane_mode_on", command)

    def test_empty_response_shape_matches_protocol(self):
        response = empty_response("identity", True, "out", "err", 0)
        self.assertEqual(
            set(response.keys()),
            {"ok", "mode", "target", "stdout", "stderr", "exit_code"},
        )
        self.assertEqual(response["target"], "emulator-only")

    @patch("rom_lab.bridge.emulator_readonly_json_wrapper.subprocess.run")
    def test_run_request_returns_structured_success_response(self, mock_run):
        completed = Mock()
        completed.returncode = 0
        completed.stdout = "hello"
        completed.stderr = ""
        mock_run.return_value = completed

        response = run_request({"mode": "identity"})

        self.assertTrue(response["ok"])
        self.assertEqual(response["mode"], "identity")
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["stdout"], "hello")
        self.assertEqual(response["stderr"], "")
        self.assertEqual(response["exit_code"], 0)

    def test_run_request_returns_structured_validation_error(self):
        response = run_request({"mode": "identity", "serial": "ZY227JQC67"})
        self.assertFalse(response["ok"])
        self.assertEqual(response["target"], "emulator-only")
        self.assertEqual(response["exit_code"], 2)
        self.assertIn("Forbidden request fields", response["stderr"])


if __name__ == "__main__":
    unittest.main()
