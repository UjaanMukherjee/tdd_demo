# tdd_demo

A minimal Flutter project focused on Test-Driven Development (TDD).

This repository is a compact example showing how to drive design with tests. The main example implemented here is a small String Calculator (following common TDD kata patterns) with unit tests that demonstrate writing failing tests first and implementing the minimal code to make them pass.

## Goals

- Provide a tiny TDD-ready Flutter/Dart project structure.
- Showcase a simple TDD cycle using a String Calculator example.
- Include runnable tests and convenient VS Code launch configurations for testing.

---

## Project layout

- `lib/string_calculator.dart` — implementation for the String Calculator API (add function and helper behavior).
- `lib/main.dart` — minimal entrypoint (empty) so the project contains no UI boilerplate.
- `test/string_calculator_test.dart` — unit tests that drive the String Calculator implementation.
- `.vscode/launch.json` — includes "Run All Tests" and "Run Current Test File" configurations for convenience.

## How to run the tests

From the project root:

```powershell
flutter pub get
flutter test
```

Or use the VS Code Run and Debug view and choose "Flutter: Run All Tests" (configured in `.vscode/launch.json`). The VS Code Testing view (beaker icon) will also list discovered tests if the Dart & Flutter extensions are enabled and the workspace is opened at the project root.

---

## String Calculator — behavior summary

The repository contains a small `add` function that accepts a string of numbers and returns their sum. It supports:

- Default delimiters: comma (`,`) and newline (`\n`).
- Optional custom delimiter declared on the first line using the format `//<delimiter>\n` or `//[<multi-char delimiter>]\n`.
- Ignores empty tokens and trims whitespace.

Example inputs and expected outputs:

- `""` -> `0`
- `"1"` -> `1`
- `"1,2,3"` -> `6`
- `"1\n2,3"` -> `6`
- `"//;\n1;2"` -> `3`
- `"//[***]\n1***2***3"` -> `6`

## Key code snippets

`lib/string_calculator.dart` (core `add` implementation):

```dart
int add(String input) {
	if (input.trim().isEmpty) return 0;

	String numbers = input;
	String delimPattern = r',|\r?\n'; // default: comma or newline

	if (input.startsWith('//')) {
		final nl = input.indexOf('\n');
		final spec = nl >= 0 ? input.substring(2, nl) : input.substring(2);
		final delim = (spec.startsWith('[') && spec.endsWith(']'))
				? spec.substring(1, spec.length - 1)
				: spec;
		delimPattern = RegExp.escape(delim) + r'|,|\r?\n';
		numbers = nl >= 0 ? input.substring(nl + 1) : '';
	}

	final parts = numbers
			.split(RegExp('(?:$delimPattern)+'))
			.map((s) => s.trim())
			.where((s) => s.isNotEmpty)
			.toList();

	return parts.map(int.parse).fold(0, (a, b) => a + b);
}
```

`test/string_calculator_test.dart` (high level descriptions and examples):

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_demo/string_calculator.dart';

void main() {
	// Example tests that show expected behavior. The actual test file in this
	// repo contains similar cases — open `test/string_calculator_test.dart` to
	// see the exact assertions used by the project.

	test('Adding with empty string', () {
		expect(add(''), 0);
	});

	test('Adding single number', () {
		expect(add('1'), 1);
	});

	test('Adding multiple numbers with commas and newlines', () {
		expect(add('1,2\n3'), 6);
	});

	test('Custom single-char delimiter', () {
		expect(add('//;\n1;2'), 3);
	});
}
```

> Note: The real test file in this project is `test/string_calculator_test.dart`. Open it to see the exact assertions and more cases.

### Test descriptions

- `Adding with empty string` — Verifies that an empty input returns `0`. This is usually the first (green) case in the TDD kata and prevents null/empty handling regressions.

- `Adding single number` — Ensures a single-number input returns that number (e.g., `"1"` -> `1`). This confirms basic parsing and integer conversion.

- `Adding multiple numbers with commas and newlines` — Checks that the default delimiters (comma and newline) are both recognized and that mixing them still returns the correct sum (e.g., `"1,2\n3"` -> `6`). This validates the default split behavior and trimming of tokens.

- `Custom single-char delimiter` — Validates support for a custom single-character delimiter provided on the first line using the `//<delim>\n` syntax (e.g., `"//;\n1;2"` -> `3`). This demonstrates how the function reads a delimiter header and applies it to the remaining input.

These descriptions map directly to the tests in `test/string_calculator_test.dart` and explain the intent behind each assertion — helpful for readers learning the TDD flow.

---

## Notes & next steps

- This repository is intentionally minimal. If you want, I can expand further on it

---

License: Unlicensed example code — use as you like for learning and experimentation.
