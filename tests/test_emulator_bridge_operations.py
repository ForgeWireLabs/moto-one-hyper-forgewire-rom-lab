import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CONTRACT_PATH = ROOT / 'rom_lab' / 'bridge' / 'emulator_readonly_contract.json'
OPERATIONS_PATH = ROOT / 'rom_lab' / 'bridge' / 'emulator_readonly_operations.json'


class EmulatorBridgeOperationsTests(unittest.TestCase):
    def load_json(self, path):
        with path.open('r', encoding='utf-8') as fh:
            return json.load(fh)

    def test_operations_file_exists(self):
        self.assertTrue(OPERATIONS_PATH.exists())

    def test_operations_are_subset_of_contract_allowed_modes(self):
        contract = self.load_json(CONTRACT_PATH)
        operations = self.load_json(OPERATIONS_PATH)
        allowed = set(contract['allowed_modes'])
        operation_modes = {op['mode'] for op in operations['operations']}
        self.assertEqual(operation_modes, allowed)

    def test_all_operations_are_read_only(self):
        operations = self.load_json(OPERATIONS_PATH)
        for op in operations['operations']:
            self.assertTrue(op['read_only'], op['mode'])

    def test_operations_target_emulator_only(self):
        operations = self.load_json(OPERATIONS_PATH)
        self.assertEqual(operations['target'], 'emulator-only')
        self.assertEqual(operations['runner'], 'rom_lab/bridge/run_readonly_bridge.ps1')
        self.assertEqual(operations['contract'], 'rom_lab/bridge/emulator_readonly_contract.json')

    def test_operations_do_not_describe_write_actions(self):
        text = OPERATIONS_PATH.read_text(encoding='utf-8').lower()
        forbidden = [
            'flash',
            'erase',
            'wipe',
            'sideload',
            'install',
            'uninstall',
            'push',
            'pull',
            'reboot bootloader',
            'fastboot',
            'remount',
            'root',
            'mkfs',
        ]
        for term in forbidden:
            self.assertNotIn(term, text)

    def test_bounded_logcat_parameters(self):
        operations = self.load_json(OPERATIONS_PATH)
        by_mode = {op['mode']: op for op in operations['operations']}
        for mode in ['logcat-tail', 'all']:
            params = by_mode[mode]['parameters']
            self.assertIn('LogLines', params)
            self.assertEqual(params['LogLines']['minimum'], 1)
            self.assertLessEqual(params['LogLines']['maximum'], 1000)


if __name__ == '__main__':
    unittest.main()
