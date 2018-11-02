
# Project 22. Detect-a-Beacon

## Concepts

- Core Location
- `CLLocationManager`, `CLLocationManagerDelegate`
- `CLBeaconRegion`
- `CLProximity`

## Notes

Requesting location acess requires a change to your apps `Info.plist` file. Depending on wheter you want "always" access or just "when in use" you need to select one key or the other.

- **Always**: "Privacy - Location Always Usage Description".
- **Only in use**: "Privacy - Location When In Use Usage Description".

Both keys should be set to a String type.

### Core Location

The Core Location class lets us configure how we want to be notified about location, and will also deliver location updates to us.

### iBeacons

iBeacons are identified using three pieces of information: 

1. **UUID**.
2. **A major number**. A long hexadecimal string that you can create by running the `uuidgen` in a Mac terminal. This number is used to subdivide within the UUID. If you have 10000 stores, you would use the same UUID for them all but give each one a different major number (bewteen 1 and 65535).
3. **A minor number**. It can be used to subdivide within the major number. 


