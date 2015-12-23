# Concurrent

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods compatible](https://img.shields.io/badge/pod-1.2.0-brightgreen.svg?style=flat)](https://img.shields.io/badge/pod-1.2.0-brightgreen.svg?style=flat)

`Concurrent` is a minimum concurrency programming library that is influenced by Google Go Language and Rust Language.  
The Library is now developing for iOS 8 and OSX Yosemite and written in Apple Swift 2.

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
