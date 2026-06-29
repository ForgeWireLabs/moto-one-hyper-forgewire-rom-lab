import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
WRAPPER = ROOT / "scripts" / "show_forgelink_operator_status.ps1"


class ForgeLinkOperatorStatusWrapperTests(unittest.TestCase):
    def test_wrapper_exists(self):
        self.assertTrue(WRAPPER.exists())

    def test_wrapper_sets_repo_pythonpath(self):
        text = WRAPPER.read_text(encoding="utf-8")
        self.assertIn("$env:PYTHONPATH", text)
        self.assertIn("$RepoRoot", text)
        self.assertIn("Push-Location $RepoRoot", text)

    def test_wrapper_calls_forgelink_adapter_not_raw_bridge(self):
        text = WRAPPER.read_text(encoding="utf-8")
        self.assertIn("rom_lab.bridge.forgelink_adapter_stub", text)
        self.assertIn("dispatch_request", text)
        self.assertIn('"operator-status"', text)
        self.assertNotIn("emulator_readonly_json_wrapper", text)
        self.assertNotIn("run_readonly_bridge.ps1", text)
        self.assertNotIn("invoke_emulator_adb_readonly.ps1", text)
        self.assertNotIn("adb.exe", text)
        self.assertNotIn("fastboot", text.lower())

    def test_wrapper_emits_json_only_from_adapter_response(self):
        text = WRAPPER.read_text(encoding="utf-8")
        self.assertIn("json.dumps(response, indent=2)", text)
        self.assertIn("request_id", text)
        self.assertIn("manual-op-001", text)
        self.assertNotIn("Write-Host", text)


if __name__ == "__main__":
    unittest.main()
