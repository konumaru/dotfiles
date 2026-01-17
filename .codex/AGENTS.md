# Global Codex Guidance

## Principles
- Honor project/local AGENTS files; nearest scope overrides this global file.
- Prefer small, focused diffs and delete dead code; avoid speculative work.
- **Fail fast with explicit errors; avoid silent fallbacks or hidden magic.**
- Use the repository's package manager/lockfile (default to pnpm for JS/TS); ask before adding dependencies.
- Keep secrets/credentials out of code and git; do not edit .env* contents.
- Follow existing patterns and conventions in the codebase you are touching.

## Testing & quality
- Write and run targeted tests/checks for affected areas when feasible; state clearly what was and was not run.
- Document non-obvious behavior changes with brief comments or notes.
- Maintain accessibility on UI work (keyboard support, labels, focus states).

## Collaboration
- Surface assumptions and risks early; ask minimal, high-signal questions when specs are unclear.
- Keep summaries concise with path references; suggest next steps only when helpful.
