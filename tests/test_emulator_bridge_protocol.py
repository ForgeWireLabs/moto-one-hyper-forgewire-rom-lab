import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROTOCOL_PATH = ROOT / 'rom_lab' / 'bridge' / 'emulator_readonly_protocol.json'
CONTRACT_PATH = ROOT / 'rom_lab' / 'bridge' / 'emulator_readonly_contract.json'
OPERATIONS_PATH = ROOT / 'rom_lab' / 'bridge' / 'emulator_readonly_operations.json'
RUNNER_PATH = ROOT / 'rom_lab' / 'bridge' / 'run_readonly_bridge.ps1'


class EmulatorBridgeProtocolTests(unittest.TestCase):
    def load_json(self, path):
        with path.open('r', encoding='utf-8') as fh:
            return json.load(fh)

    def test_protocol_file_exists(self):
        self.assertTrue(PROTOCOL_PATH.exists())

    def test_protocol_references_existing_bridge_layers(self):
        protocol = self.load_json(PROTOCOL_PATH)
        self.assertEqual(protocol['contract'], 'rom_lab/bridge/emulator_readonly_contract.json')
        self.assertEqual(protocol['operations'], 'rom_lab/bridge/emulator_readonly_operations.json')
        self.assertEqual(protocol['runner'], 'rom_lab/bridge/run_readonly_bridge.ps1')
        self.assertTrue(CONTRACT_PATH.exists())
        self.assertTrue(OPERATIONS_PATH.exists())
        self.assertTrue(RUNNER_PATH.exists())

    def test_protocol_target_is_emulator_only(self):
        protocol = self.load_json(PROTOCOL_PATH)
        self.assertEqual(protocol['target'], 'emulator-only')
        self.assertEqual(protocol['response']['target_value'], 'emulator-only')

    def test_request_does_not_allow_direct_target_or_command_fields(self):
        protocol = self.load_json(PROTOCOL_PATH)
        forbidden = set(protocol['forbidden_request_fields'])
        required = {
            'serial',
            'device_serial',
            'adb_args',
            'shell',
            'command',
            'fastboot_args',
            'path_to_push',
            'path_to_pull',
        }
        self.assertTrue(required.issubset(forbidden))

    def test_protocol_request_mode_is_required(self):
        protocol = self.load_json(PROTOCOL_PATH)
        self.assertEqual(protocol['request']['required_fields'], ['mode'])

    def test_protocol_modes_come_from_operations_catalog(self):
        protocol = self.load_json(PROTOCOL_PATH)
        self.assertIn('emulator_readonly_operations.json', protocol['request']['mode_source'])

    def test_forbidden_behavior_blocks_write_paths(self):
        protocol = self.load_json(PROTOCOL_PATH)
        text = '\n'.join(protocol['forbidden_behavior']).lower()
        required_terms = [
            'arbitrary adb arguments',
            'arbitrary shell commands',
            'physical device serial',
            'fastboot',
            'write',
            'flash',
            'erase',
            'install',
            'uninstall',
            'sideload',
            'reboot',
            'remount',
            'root',
            'wipe',
            'repair',
            'rescue',
        ]
        for term in required_terms:
            self.assertIn(term, text)


if __name__ == '__main__':
    unittest.main()
