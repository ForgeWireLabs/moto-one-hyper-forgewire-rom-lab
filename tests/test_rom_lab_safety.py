import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
LARGE_THRESHOLD = 5 * 1024 * 1024
FORBIDDEN_SUFFIXES = {
    ".img",
    ".zip",
    ".bin",
    ".payload",
    ".br",
    ".dat",
    ".mbn",
    ".elf",
    ".sin",
    ".ofp",
    ".ops",
    ".tar",
    ".tgz",
    ".xz",
    ".7z",
}
ALLOWED_SCRIPT_DENYLIST_TERMS = {
    "fastboot flash",
    "fastboot erase",
    "fastboot flashing lock",
    "fastboot oem lock",
    " dd ",
    "mkfs",
}


def iter_repo_files():
    for path in ROOT.rglob("*"):
        if ".git" in path.parts or "__pycache__" in path.parts:
            continue
        if path.is_file():
            yield path


class RomLabSafetyTests(unittest.TestCase):
    def test_no_large_or_forbidden_binary_artifacts(self):
        offenders = []
        for path in iter_repo_files():
            if path.suffix.lower() in FORBIDDEN_SUFFIXES or path.stat().st_size > LARGE_THRESHOLD:
                offenders.append(path.relative_to(ROOT).as_posix())
        self.assertEqual(offenders, [])

    def test_destructive_commands_are_not_in_execution_scripts(self):
        offenders = []
        script_paths = list((ROOT / "scripts").glob("*.ps1"))
        script_paths += list((ROOT / "rom_lab" / "scripts").glob("*.ps1"))
        for path in script_paths:
            text = path.read_text(encoding="utf-8").lower()
            for term in ALLOWED_SCRIPT_DENYLIST_TERMS:
                if term in text:
                    offenders.append(f"{path.relative_to(ROOT).as_posix()}: {term}")
        self.assertEqual(offenders, [])


if __name__ == "__main__":
    unittest.main()
