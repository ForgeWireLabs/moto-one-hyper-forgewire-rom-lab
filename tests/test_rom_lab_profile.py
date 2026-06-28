import json
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROFILE = ROOT / "rom_lab" / "device_def" / "device_profile.json"


class RomLabProfileTests(unittest.TestCase):
    def load_profile(self):
        return json.loads(PROFILE.read_text(encoding="utf-8"))

    def test_device_profile_required_fields(self):
        data = self.load_profile()
        required = {
            "model",
            "sku",
            "codename",
            "target",
            "carrier",
            "soc",
            "storage",
            "ram",
            "android_stock",
            "build",
            "active_slot",
            "bootloader_unlocked",
            "stock_boot_verified",
            "root_available",
            "partitions",
        }
        self.assertLessEqual(required, set(data))
        self.assertEqual(data["sku"], "XT2027-1")
        self.assertEqual(data["codename"], "def")
        self.assertEqual(data["soc"], "sm6150")

    def test_stock_boot_and_root_are_not_claimed(self):
        data = self.load_profile()
        self.assertIs(data["stock_boot_verified"], False)
        self.assertIs(data["root_available"], False)


if __name__ == "__main__":
    unittest.main()
