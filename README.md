# Proc

Convenient process API for Swift.

![Swift 5](https://img.shields.io/badge/swift-5-important)
![Platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20Linux-lightgrey)
![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen)
![release](https://img.shields.io/github/release/nikstar/Proc)
![GitHub](https://img.shields.io/github/license/nikstar/Proc)

- [x] Read standard output into a string
- [x] Pipe several commands together
- [x] Change environment

See `ProcExample` for working example.

**This is work in progress. PRs and suggestions are welcome!**

Add to your project via Swift package manager:

```
        .package("https://github.com/nikstar/Proc.git", from: "1.0.0")
```

## Examples

```swift
let ls = Proc("/bin/ls")
let sort = Proc("/usr/bin/sort", "-r")
let wc = Proc("/usr/bin/xargs", "wc", "-c")

let output = try ls
    .pipe(to: sort)
    .pipe(to: wc)
    .runForStdout()
```

Default initializer takes absolute or relative path as first argument. Convenience initializer `init(name:)` takes the name of the tool and uses `env` behind the scenes. `/usr/local/bin` is added to `$PATH` enviroment variable.

```swift
let ffmpeg = Proc(name: "ffmpeg", "-version") 
// same as Proc("/usr/bin/env", "ffmpeg", "-version") + modified $PATH

try ffmpeg.run()
ffmpeg.waitUntilExit()
```

Environment is inhereted from current process and can be modified using `environment`:

```swift
let srv = Proc(name: "myserver")
    .environment { env in 
        env["ACCESS_TOKEN"] = token
    }
```
