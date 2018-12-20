
# Project 26. Marble Maze.

## Concepts

- `categoryBitMask`
- `collisionBitMask`
- `contactTestBitMask` 
- Core Motion framework.
- `CMMotionManager`
- Compiler Directives: `#if #else #endif`


## Notes

- The `categoryBitMask` property is a number defining the type of object this is for considering collisions.
- The `collisionBitMask` property is a number defining what categories of object this node should collide with. By default, physics bodies have a collision bit mask that means "everything".  
- The `contactTestBitMask` property is a number defining which collisions we want to be notified about. By default, physics bodies have a contact test bit mask that means "nothing", sou you will never get told about collisions.

