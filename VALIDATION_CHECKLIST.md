# Scaffold Validation Checklist

Run this checklist after generating project scaffolding.

## Required counts
- [ ] 5 workflow files in `.github/workflows/`
- [ ] 9 agent specs in `.github/agents/`
- [ ] 3 issue templates in `.github/ISSUE_TEMPLATE/`
- [ ] 9 scripts in `scripts/`
- [ ] 5 OAuth2 example files in `examples/oauth2-auth/`

## One-command verification
```bash
bash scripts/validate-scaffold.sh
```

The command validates expected paths and file counts and exits non-zero on mismatch.
