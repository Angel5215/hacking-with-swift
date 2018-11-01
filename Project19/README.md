
# Project 19. Capital Cities

## Concepts

- MapKit
- `CLLocationCoordinate2D`
- Protocols
- `MKAnnotation` protocol
- `MKPinAnnotationView`

## Notes

MapKit is Apple's mapping framework that lets us drop pins, plan routes, and zoom around the world with just a few swipes.

Annotations are objects tat contain a title, a subtitle and a position. The first two are both strings, the third is a new data type called `CLLocationCoordinate2D`, which is a structure that holds a **latitude** and **longitude** for where the annotation should be placed.

There's a `mapType` property that draws maps in different ways. For example, `.satellite` gives a satellite view of the terrain.

