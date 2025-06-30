# Pre-Commit Checklist

## Code Quality
- [ ] No magic numbers (use config.js)
- [ ] No console.log in production code (use debugLog)
- [ ] Tests pass (`npm test` in soulforge, `rails test` in soulsoup)
- [ ] API calls have error handling and graceful degradation

## Soul-Specific
- [ ] Events include incarnation_id
- [ ] Soul modifiers applied correctly
- [ ] Graceful degradation without API
- [ ] Event batching working (5-second intervals)

## Git Hygiene
- [ ] Branch name follows pattern: `feature/soul-*`, `fix/*`, `docs/*`
- [ ] Commit message format: `type(component): description`
- [ ] Issue reference included: `Closes #123` or `Part of #123`
- [ ] Co-Authored-By added for Claude commits

## Documentation
- [ ] Updated relevant CLAUDE.md if patterns changed
- [ ] Updated PROJECT_STATUS.md if major work completed
- [ ] Added ADR in docs/adr/ if architectural decision made
- [ ] Updated configuration metadata if new config values added

## Testing
- [ ] Tested full soul lifecycle (creation → gameplay → events)
- [ ] Verified in both 2D and 3D renderers
- [ ] Checked browser console for errors
- [ ] Tested with API both on and off

## Before Push
- [ ] All changes committed
- [ ] Branch pushed to origin
- [ ] Ready to create PR with proper description