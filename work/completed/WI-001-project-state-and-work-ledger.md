# WI-001 - Project State and Work Ledger

Status: active

## Goal

Create a durable project state file and a versioned work ledger so future work does not depend on chat history.

## Why

The repository contract says critical state must live in versioned files. This work item makes the public repo usable as memory for ChatGPT, Codex, other agents, and Jeremy.

## Scope

In scope:

- PROJECT_STATE.md
- work/README.md
- initial work item files
- clear status values
- clear safety rule

Out of scope:

- code changes
- emulator execution
- physical phone actions

## Deliverables

- PROJECT_STATE.md exists
- work/README.md exists
- initial work items exist
- validation passes
- commit is pushed to main

## Acceptance

- `python scripts/validate_repo.py` passes
- `python -m unittest discover -s tests -v` passes
- `git status --short` is clean after commit
- the public repository shows the work ledger on main

## Safety

No device interaction.
