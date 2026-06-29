import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CONTRACT_PATH = ROOT / 'rom_lab' / 'bridge' / 'emulator_readonly_contract.json'
README_PATH = ROOT / 'rom_lab' / 'bridge' / 'README.md'


class EmulatorBridgeContractTests(unittest.TestCase):
    def load_contract(self):
        with CONTRACT_PATH.open('r', encoding='utf-8') as fh:
            return json.load(fh)

    def test_contract_files_exist(self):
        self.assertTrue(CONTRACT_PATH.exists())
        self.assertTrue(README_PATH.exists())

    def test_contract_target_is_emulator_only(self):
        contract = self.load_contract()
        target = contract['target']
        self.assertEqual(target['type'], 'android-emulator')
        self.assertEqual(target['avd_name'], 'forge_moto_one_hyper_lab_api35')
        self.assertEqual(target['required_serial_pattern'], '^emulator-[0-9]+$')
        self.assertFalse(target['physical_device_allowed'])

    def test_contract_entrypoints_exist(self):
        contract = self.load_contract()
        for rel_path in contract['entrypoints'].values():
            self.assertTrue((ROOT / rel_path).exists(), rel_path)

    def test_allowed_modes_are_named_readonly_modes(self):
        contract = self.load_contract()
        expected = {
            'devices',
            'boot',
            'identity',
            'packages',
            'logcat-tail',
            'prop-read',
            'settings-read',
            'activity-list',
            'storage-read',
            'network-read',
            'process-list',
            'operator-status',
            'all',
        }
        self.assertEqual(set(contract['allowed_modes']), expected)

    def test_forbidden_families_cover_destructive_paths(self):
        contract = self.load_contract()
        forbidden = '\n'.join(contract['forbidden_command_families']).lower()
        required_terms = [
            'adb push',
            'adb pull',
            'adb install',
            'adb uninstall',
            'adb reboot',
            'adb sideload',
            'fastboot flash',
            'fastboot erase',
            'fastboot format',
            'fastboot update',
            'fastboot boot',
            'fastboot flashing lock',
            'wipe',
            'factory reset',
            'dd to block devices',
            'mkfs',
            'mount -o remount,rw',
        ]
        for term in required_terms:
            self.assertIn(term, forbidden)

    def test_safety_invariants_keep_phone_out_of_scope(self):
        contract = self.load_contract()
        invariants = '\n'.join(contract['safety_invariants']).lower()
        self.assertIn('must not select or operate on a physical android device serial', invariants)
        self.assertIn('must expose named read-only modes', invariants)
        self.assertIn('physical motorola one hyper must not be flashed', invariants)


if __name__ == '__main__':
    unittest.main()
