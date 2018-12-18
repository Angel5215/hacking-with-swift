
# Project 25. Selfie Share.

## Concepts
- Collection Views
- Grand Central Dispatch
- Image Picker
- Multipeer connectivity framework.

## Notes

Multipeer connectivity requires four classes:

1. **`MCSession`** is the manager class that handles al multipeer connectivity for us.
2. **`MCPeerID`** identifies each user uniquely in a session.
3. **`MCAdvertiserAssistant`** is used when creating a session, telling others that we eist and handling invitations.
4. **`MCBrowserViewController`** is used when looking for sessions, showing users who is nearby and letting them join.

These classes are defined in the multipeer framework: `import MultipeerConnectivity`.

All multipeer services on iOS must **declare a service type**, which is a 15-digit string that uniquely identify your service. Those 15 digits can contain only the letters A-Z, numbers and hyphens. It's usually preferred to include your company in there somehow.

The service type is used by both `MCAdvertiserAssistant` and `MCBrowserViewController` to make sure your users only see other users of the same app. The also want a reference to the `MCSession` instance so they can take care of connections for you.

When a user connects or disconnects from our session, the method `session(_:peer:didChangeState:)` is called so you know what's changed - is someone connecting,are they now connected, or have they just disconnected?

