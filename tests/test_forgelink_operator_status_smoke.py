import ast
import io
import unittest
from contextlib import redirect_stdout
from pathlib import Path

from rom_lab.bridge import forgelink_operator_status_smoke as smoke


ROOT = Path(__file__).resolve().parents[1]
MODULE = ROOT / "rom_lab" / "bridge" / "forgelink_operator_status_smoke.py"
WRAPPER = ROOT / "scripts" / "smoke_forgelink_operator_status.ps1"


class ForgeLinkOperatorStatusSmokeTests(unittest.TestCase):
    def test_module_and_wrapper_exist(self):
        self.assertTrue(MODULE.exists())
        self.assertTrue(WRAPPER.exists())

    def test_deterministic_smoke_passes(self):
        report = smoke.run_smoke(live=False)
        self.assertTrue(report["ok"])
        self.assertEqual(report["failure_count"], 0)
        self.assertFalse(report["live"])

    def test_ready_scenario_validates_safety_invariants(self):
        report = smoke.run_smoke(live=False)
        ready = next(s for s in report["scenarios"] if s["scenario"] == "ready")
        names = {check["check"] for check in ready["checks"]}
        self.assertIn("target is emulator-only", names)
        self.assertIn("authority is readonly-emulator-inspection", names)
        self.assertIn("mode is operator-status", names)
        self.assertTrue(all(check["pass"] for check in ready["checks"]))

    def test_degraded_scenario_is_always_validated(self):
        report = smoke.run_smoke(live=False)
        degraded = next(s for s in report["scenarios"] if s["scenario"] == "degraded")
        self.assertTrue(all(check["pass"] for check in degraded["checks"]))

    def test_check_catches_a_broken_envelope(self):
        broken = {"ok": True, "target": "physical", "mode": "operator-status"}
        checks = smoke.check_ready_envelope(broken)
        self.assertFalse(all(check["pass"] for check in checks))

    def test_main_returns_zero_on_deterministic_run(self):
        with redirect_stdout(io.StringIO()):
            self.assertEqual(smoke.main([]), 0)
            self.assertEqual(smoke.main(["--json"]), 0)

    def test_module_does_not_use_subprocess_and_delegates_to_adapter(self):
        tree = ast.parse(MODULE.read_text(encoding="utf-8"))
        imported = set()
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                imported.update(alias.name for alias in node.names)
            elif isinstance(node, ast.ImportFrom) and node.module:
                imported.add(node.module)
        self.assertNotIn("subprocess", imported)
        self.assertIn("rom_lab.bridge.forgelink_adapter_stub", imported)

    def test_wrapper_sets_pythonpath_and_calls_module(self):
        text = WRAPPER.read_text(encoding="utf-8")
        self.assertIn("$env:PYTHONPATH", text)
        self.assertIn("Push-Location $RepoRoot", text)
        self.assertIn("forgelink_operator_status_smoke.py", text)
        self.assertNotIn("python -c", text)


if __name__ == "__main__":
    unittest.main()
