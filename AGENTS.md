# AGENTS.md

## Project Overview

Yamada is a cross-platform Flutter application with Material.

## Tech Stack

- **Riverpod** for state management
- **GoRouter** for declarative routing
- **SharedPreferences** for local persistence

## Localization

- ARB files in `lib/locales/` (template: `en.arb`)
- Config in `l10n.yaml` at project root
- `constants.dart` is the single source of truth for `supportedLocales`
- Key naming: camelCase with prefixes by feature or module
- Only add `@key` metadata descriptions for proper nouns needing context

## Code Style

- No comments unless explicitly requested
- Follow existing patterns and conventions in the codebase
- Run `flutter analyze` after changes; fix all issues before committing
