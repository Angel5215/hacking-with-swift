
# Project 28. Secret Swift.

## Concepts

- Touch ID, Face ID.
- Keychain.
- `KeychainWrapper` by Jason Rendel (MIT License) -> [GitHub](https://github.com/jrendel/SwiftKeychainWrapper).
- `resignFirstResponder()`
- Local Authentication framework.
- `LAContext`, `canEvaluatePolicy()`, `.deviceOwnerAuthenticationWithBiometrics`

## Notes

The **Keychain** is a secure, encrypted data storage area on every device that you can read and write to.

The `resignFirstResponder()` method is used to tell a view that has input focus that it should give up that focus. This is used to tell the text view that we're finished editing it, so the **keyboard can be hidden**.

### TouchID, FaceID

Touch ID and Face ID are part of the *Local Authentication* framework. In this application the code does three things:

1. Check whether the device is capable of supporting biometric authentication.

2. If so, request that the biometry system begin a check now, giving it a string containing the reason why we're asking.
    - For TouchID, the string is written in code.
    - For FaceID, the string is written into the `Info.plist` file. You need to add a key called **"Privacy - Face ID Usage Description"**

3. If we get success back from the authentication request, it means this is the device's owner so we can unlock the app, otherwise, we show a failure message.
    - The success message might not be on the main thread, so we need to use `async()` to make sure we execure any user interface code on the main thread.

