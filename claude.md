## Architecture: View-Controller-Service Pattern

- **View** — Only houses the UI the user sees. No logic, no state.
- **Controller** — Extends `ChangeNotifier`. Handles all state and logic. Must have private fields for each `TextEditingController` (or other state) with public getters for UI access.
- **Service** — Responsible for fetching and saving data.

## Code Rules

- **No widget-builder functions.** Functions like `_buildAppBar()` or `_buildSomething()` that return widgets are not allowed. If you need to abstract a component, create a `StatelessWidget` (or `StatefulWidget` as needed) and colocate it in a `widgets/` folder at the same feature path.
- Do not hardcode colors in the app. Only hardcoded colors should be status indicators like error or warning. Rest of the colors should come from Theme.of(context)
- Strictly follow the above mentioned Architecture

## Philosophy

This codebase will outlive you. Every shortcut becomes someone else's burden. Every hack compounds into technical debt that slows the whole team down.

You are not just writing code. You are shaping the future of this project. The patterns you establish will be copied. The corners you cut will be cut again.

Fight entropy. Leave the codebase better than you found it.