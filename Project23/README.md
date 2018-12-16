
# Project 23. Space Race

## Concepts

- `SKEmitterNode`, `SKLabelNode`, `SKSpriteNode`
- `advanceSimulationTime()` method.
- Per-pixel collision detection.
- `linearDamping`, `angularDamping` properties of `SKSpriteNode`s.

## Notes

With the `advanceSimulationTime()` method of an emitter, you can ask SpriteKit to simulate time passing in the emitter. 

### Per-pixel collision detection

Collisions happen based on actual pixels from one object touching actual pixels in another (instead of using rectangles and circles). SpriteKit optimizes this job so that it looks like it's using actual pixels when it just uses a very close approximation.

### Linear Damping and Angular Damping

When set to a value of 0, it means that a node movement and rotation will never slow down over time.

