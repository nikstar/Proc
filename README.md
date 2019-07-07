# Proc

Convinient process API for Swift.

- [x] Read standard output into a string
- [x] Pipe several commands together

See `ProcExample` for working example.

**This is work in progress. PRs and suggestions are welcome!**

Add to your project via Swift package manager:

```
        .package("https://github.com/nikstar/Proc.git", .branch("master"))
```

## Example

```swift
let ls = Proc("/bin/ls")
let sort = Proc("/usr/bin/sort", "-r")
let wc = Proc("/usr/bin/xargs", "wc", "-c")

let output = try ls
    .pipe(to: sort)
    .pipe(to: wc)
    .runForStdout()
```

Default initializer takes absolute or relative path as first argument. Convinience initializer `init(name:)` takes the name of the tool and uses `env` behind the scenes. `/usr/local/bin` is added to `$PATH` enviroment variable.

```swift
let ffmpeg = Proc(name: "ffmpeg", "-version") 
// same as Proc("/usr/bin/env", "ffmpeg", "-version") + modified $PATH

try ffmpeg.run()
ffmpeg.waitUntilExit()
```
