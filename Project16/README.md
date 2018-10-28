
# Project 16. JavaScript Injection

## Concepts

- Safari extension.
- `NSExtensionItem`
- `UITextView`
- `NotificationCenter`
- `UIKeyboardWillHide`, `UIKeyboardWillChangeFrame`.
- `UIEdgeInsets`




## Notes

A Safari extension lets us embed a version of our app directly inside Safari's action menu to manipulate Safari data in interesting ways.

Safari extensions are launched from within the Safari action menu, but are shipped inside a parent app.

### Extension

When the extension is created, the `extensionContext` let us control how the extension interacts with its parent app.

All extensions have a `Info.plist` file that describes what data you're willing to accept and how it should be processed.

### `UITextView`

A `UITextView` is useful for letting users enter multiple lines of text.

### Notification Center

iOS is constantly sending notifications when things happen like keyboard changing, application moving to the background, as well as any custom events that applications post. We can add ourselves as an **Observer** for certain actions and a method we name will be called when a notification occurs, and will even be passed any useful information.

