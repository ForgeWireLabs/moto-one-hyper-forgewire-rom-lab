import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
RUNNER_PATH = ROOT / 'rom_lab' / 'bridge' / 'run_readonly_bridge.ps1'


class EmulatorBridgeRunnerTests(unittest.TestCase):
    def test_runner_exists(self):
        self.assertTrue(RUNNER_PATH.exists())

    def test_runner_loads_contract_before_invocation(self):
        text = RUNNER_PATH.read_text(encoding='utf-8')
        self.assertIn('emulator_readonly_contract.json', text)
        self.assertIn('ConvertFrom-Json', text)
        self.assertIn('allowed_modes', text)

    def test_runner_enforces_emulator_only_contract(self):
        text = RUNNER_PATH.read_text(encoding='utf-8')
        self.assertIn('physical_device_allowed', text)
        self.assertIn('required_serial_pattern', text)
        self.assertIn('^emulator-[0-9]+$', text)
        self.assertIn('emulator only', text.lower())

    def test_runner_does_not_expose_raw_adb_or_fastboot(self):
        text = RUNNER_PATH.read_text(encoding='utf-8').lower()
        forbidden = [
            'fastboot',
            'adb push',
            'adb pull',
            'adb install',
            'adb uninstall',
            'adb reboot',
            'adb sideload',
        ]
        for term in forbidden:
            self.assertNotIn(term, text)


if __name__ == '__main__':
    unittest.main()
