import ast
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
WRAPPER = ROOT / "scripts" / "show_forgelink_operator_status.ps1"
ENTRYPOINT = ROOT / "rom_lab" / "bridge" / "show_forgelink_operator_status.py"


class ForgeLinkOperatorStatusWrapperTests(unittest.TestCase):
    def test_wrapper_and_entrypoint_exist(self):
        self.assertTrue(WRAPPER.exists())
        self.assertTrue(ENTRYPOINT.exists())

    def test_wrapper_sets_repo_pythonpath(self):
        text = WRAPPER.read_text(encoding="utf-8")
        self.assertIn("$env:PYTHONPATH", text)
        self.assertIn("$RepoRoot", text)
        self.assertIn("Push-Location $RepoRoot", text)

    def test_wrapper_calls_python_entrypoint_not_inline_python(self):
        text = WRAPPER.read_text(encoding="utf-8")
        self.assertIn("show_forgelink_operator_status.py", text)
        self.assertIn("--request-id", text)
        self.assertNotIn("python -c", text)
        self.assertNotIn("$PythonCode", text)
        self.assertNotIn("Write-Host", text)

    def test_entrypoint_imports_only_expected_runtime_modules(self):
        tree = ast.parse(ENTRYPOINT.read_text(encoding="utf-8"))
        imported_modules = set()
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                imported_modules.update(alias.name for alias in node.names)
            elif isinstance(node, ast.ImportFrom) and node.module:
                imported_modules.add(node.module)

        self.assertEqual(
            imported_modules,
            {
                "__future__",
                "argparse",
                "json",
                "rom_lab.bridge.forgelink_adapter_stub",
            },
        )

    def test_entrypoint_calls_forgelink_adapter(self):
        text = ENTRYPOINT.read_text(encoding="utf-8")
        self.assertIn("rom_lab.bridge.forgelink_adapter_stub", text)
        self.assertIn("dispatch_request", text)
        self.assertIn('"operator-status"', text)
        self.assertIn("json.dumps(response, indent=2)", text)

    def test_entrypoint_supports_default_and_explicit_request_id(self):
        text = ENTRYPOINT.read_text(encoding="utf-8")
        self.assertIn("manual-op-001", text)
        self.assertIn("--request-id", text)
        self.assertIn("request_id", text)


if __name__ == "__main__":
    unittest.main()
