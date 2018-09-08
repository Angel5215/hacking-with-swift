
# Project 4. Easy Browser.

## Concepts

- `UIBarButtonItem`
- WebKit (`WKWebView`)
- `UIToolbar`
- Delegation (design pattern)
- Classes and Structs
- Key-value observing (KVO)
- Creating views in code. (`WKWebView`)
- `UIProgressView`
- `@escaping`

## Notes

**Delegation** is what's called a *programming pattern* - a way of writing code. 

A **delegate** is one thing acting inplace of another, effectively answering questions and responding to events on its behalf.

We set the web view's `navigationDelegate` property to `self` roughly means "when any web page navigation happens, please tell me (the View Controller)"

### HTTP

iOS does not like apps sending or receiving data insecurely. WebViews can't normally load HTTP content (only HTTPS). The following [link](https://www.hackingwithswift.com/example-code/wkwebview/how-to-load-http-content-in-wkwebview-and-uiwebview) explains a way to override this behavior.

### KVO

Key-Value Observing. Effectively, it lets us say "tell me when propety `X` of object `Y` gets changed by anyone at any time."

### Refactoring

Rewriting the code. The end result should do the same thing. Its purpose is to make it more efficient, make it easier to read, reduce its complexity and to make it more flexible.

### Closures

An `@escaping` closure has the potential of escaping the current method, and be used at a later date. In this case, the `decisionHandler` can be called straight away, or might be called later on (after asking the user what they want to do).

