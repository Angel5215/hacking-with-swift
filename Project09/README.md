
# Project 9. Grand Central Dispatch.

## Concepts

* Grand Central Dispatch (GCD)
* Quality of Service (QoS)
* Multithreading
* `performSelector(inBackground:)`
* `performSelector(onMainThread:)`


## Notes

A **blocking call** is a piece of code that blocks execution of any further code until it has connected to the server and fully downloaded all data.

### Grand Central Dispatch
 
The power of **GCD** is that it takes away a lot of the hassle of creating and working with multiple threads (**multithreading**). You don't have to worry about creating and destroying threads, and you don't have to worry about ensuring you have created the optimal number of threads for the current device. GCD automatically creates threads for us, and executes the code on them in the most efficient way it can.

`async()` runs the code asynchronously (in a way that doesn't block the main thread).

GCD works with a system of **queues** (FIFO data structure). GCD calls don't create threads to run in, they are just assigned to one of the existing threads for GCD to manage. GCD creates for you a number of queues, and places tasks in those queues depending on **how important** you say they are.

The importance of some code depends on something called **Quality of Service** (QoS) which decides what level of service this code should be given. The top level is the **Main queue**, which runs on the Main Thread and should be used to **schedule any work that must update the user interface**. There are four backgound queues:

1. **User Interactive** (highest priority)
2. **User initiated**
3. **Utility queue**: long-running tasks that the user is aware of but not necessarily desperate for.
4. **Background queue**. Long running tasks that the user isn't actively aware of.

One more option is the **default queue**, which is prioritized between user-initiated and utility.

```swift
DispatchQueue.global().async { [unowned self] in 

}

// or

DispatchQueue.global(qos: .userInitiated).async { [unowned self] in

}

```