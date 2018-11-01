
# Project 18. Debugging.

## Concepts

- `print()`
- Assertions
- Breakpoints
- View hierarchy, Capture 

## Notes

### The `print()` function

The `print()` function is a variaric function. It accepts any number of parameters. This function also has two optional parameters: `separator` and `terminator` that can be used to give format to whatever is going to be printed in the debug console.

### Assertions

Assertions are **debug-only** checks that will force your app to crash if a specific condition isn't true.

The `assert()` function takes two parameters: something to check, and a message to print out if the check fails. If the check evaluates to false, your app will be forced to crash because you know it's not in a safe state.