import json
from pathlib import Path
import unittest


ROOT = Path(__file__).resolve().parents[1]


class NoPhoneTouchPolicyTests(unittest.TestCase):
    def test_no_phone_touch_policy_exists(self):
        policy = ROOT / "reports" / "no_phone_touch_policy.md"
        self.assertTrue(policy.exists(), "no phone touch policy report must exist")

    def test_policy_requires_emulator_targets_by_default(self):
        policy = (ROOT / "reports" / "no_phone_touch_policy.md").read_text(encoding="utf-8")

        self.assertIn("emulator-*", policy)
        self.assertIn("No physical phone access is allowed by default.", policy)
        self.assertIn("The physical device is not an assumed test target.", policy)

    def test_policy_marks_known_real_serial_as_non_target(self):
        policy = (ROOT / "reports" / "no_phone_touch_policy.md").read_text(encoding="utf-8")

        self.assertIn("ZY227JQC67", policy)
        self.assertIn("Do not use this serial as an execution target.", policy)

    def test_policy_requires_current_session_gate_approval(self):
        policy = (ROOT / "reports" / "no_phone_touch_policy.md").read_text(encoding="utf-8")

        self.assertIn("current-session gate review", policy)
        self.assertIn("No standing approval carries across sessions.", policy)
        self.assertIn("Jeremy approves the exact command in the current session.", policy)

    def test_bridge_contract_still_blocks_physical_devices(self):
        contract_path = ROOT / "rom_lab" / "bridge" / "emulator_readonly_contract.json"
        contract = json.loads(contract_path.read_text(encoding="utf-8"))

        self.assertFalse(contract.get("physical_device_allowed"))
        self.assertEqual(contract.get("target"), "android-emulator")
        self.assertEqual(contract.get("required_serial_pattern"), "^emulator-[0-9]+$")

    def test_bridge_protocol_rejects_direct_targeting_fields(self):
        protocol_path = ROOT / "rom_lab" / "bridge" / "emulator_readonly_protocol.json"
        protocol = json.loads(protocol_path.read_text(encoding="utf-8"))

        forbidden_fields = set(protocol["request"]["forbidden_fields"])

        self.assertIn("serial", forbidden_fields)
        self.assertIn("device_serial", forbidden_fields)
        self.assertIn("adb_args", forbidden_fields)
        self.assertIn("fastboot_args", forbidden_fields)
        self.assertIn("command", forbidden_fields)
        self.assertIn("shell", forbidden_fields)


if __name__ == "__main__":
    unittest.main()
