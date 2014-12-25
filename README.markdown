# Concurrent

[![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/moriturus/Concurrent?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

`Concurrent` is a minimum concurrency programming library that is influenced by Google Go Language and Rust Language.  
The Library is now developing for iOS 8 and OSX Yosemite and written in Apple Swift.

# Usage

```swift
let ch = Channel<UInt>()

Dispatch.async {

    Dispatch.apply(1000) {

        i in

        ch.send(i)

    }
    
    return

}

for _ in 0..<1000 {

    let val = ch.receive()
    println(val)

}
```

# License

`Concurrent` is available under the MIT License. See LICENSE file for more info.
