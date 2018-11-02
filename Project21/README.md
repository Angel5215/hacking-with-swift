
# Project 21. Local Notifications

## Concepts

-  `UNUserNotificationCenter` -> `requestAuthorization()`
- `DateComponents`
- `UNMutableNotificationContent`
- `UUID`
- `UNNotificationAction`, `UNNotificationCategory`
- `UNNotificationDefaultActionIdentifier`

## Notes

Local notifications let you send reminders to your user's lock screen to show them information when your app isn't running. If you set a reminder in your calendar, making it pop up on your lock screen at the right time is a local notification.

Local notifications are **NOT** the same as Push Notifications. Push notifications require a dedicated server (or service) to send from. CloudKit is a possible alternative to send push notifications when data is changed.

You can't post messages to the user's lock screen unless you have their permission. Thus, in order to send local notification in an app, you need to request permission. 

To schedule a notification you need three things:

1. **Content**: what to show.
2. A **trigger**: when to show it.
3. A **request**: the combination of content and trigger.

The reason a notification request is split into two smaller components is that they are interchangeable. A trigger can be a **calendar trigger** (shows the notification at an exact time), it can be an **interval trigger** (shows the notification after a certain timer interval has lapsed), or it can be a **geofence** (shows the notification based on the user's location).

### Example: Using `DateComponents`

Create an alarm at 10:30 am every morning:

```swift
var dateComponents = DateComponents()
dateComponents.hour = 10
dateComponents.minute = 30

let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
```

### `UNMutableNotificationContent`

This class allows to customize how notifications are shown. It has a lot of properties, the most common ones are the following:

- `title`: Main title of the alert. Should be a couple words at most.
- `body`: Main text.
- `sound`: Create a `UNNotificationSound` to attach it to the notification.
- `userInfo`: a dictionary containing custom data, e.g. an internal ID.
- `categoryIdentifier`: Allows to attach custom actions to the notification.

```swift
let content = UNMutableNotificationContent()
content.title = "Title goes here"
content.body = "Main text goes here"
content.categoryIdentifier = "customIdentifier"
content.userInfo = ["customData": "fizzbuzz"]
content.sound = UNNotificationSound.default()
```

---

Each notification has a **unique identifier**. this is just a string you create, but it does need to be unique because it lets you update or remove notifications programatically. This name can be created from the `UUID` class.

### `UNNotificationAction` and `UNNotificationCategory`

This class is used to show one or more options alongside your alert, then respond to the user's choice. Creating a `UNNotificationAction` requires three parameters:

1. An **identifier**: unique string that gets sent to you when the button is tapped.
2. A **title**: what users see in the interface.
3. **Options**: they describe any special options that relate to the action. You can choose `.authenticationRequired`, `.destructive` and `.foreground`.

When you have as many actions as you want, you group them together into a single `UNNotificationCategory` and give it the same identifier you used with a notification.

### `UNNotificationDefaultActionIdentifier`

It gets sent when the user swiped on the notification to unlock their device and launch the app.




