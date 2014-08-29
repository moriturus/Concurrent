# Concurrent

`Concurrent` is a minimum concurrency programming library that is influenced by Google Go Language and Rust Language.  
The Library is now developing for iOS 8 and OSX Yosemite and written in Apple Swift.

# Usage

```swift
let ch = Channel<UInt>()

async {

    apply(1000) {

        i in

        ch.send(i)

    }

}

for _ in 0..<1000 {

    let val = ch.receive()
    println(val)

}
```

or

```swift
let (s,r) = Channel<UInt>.gateways()

async {

    apply(1000) {

        i in

        s.send(i)

    }

}

for _ in 0..<1000 {

    let val = r.receive()
    println(val)

}
```

# License

`Concurrent` is available under the MIT License. See LICENSE file for more info.
