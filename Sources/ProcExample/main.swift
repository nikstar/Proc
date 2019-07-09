import Foundation
import Proc

let ls = Proc("/usr/bin/env", "find", ".", "-type", "f")
let sort = Proc("/usr/bin/sort", "-rh")
let wc = Proc("/usr/bin/xargs", "wc", "-c")
let ffmpeg = Proc(name: "ffmpeg", "-v")

do {
//    let p = ls
//        .pipe(to: wc)
//        .pipe(to: sort)
    let p = ffmpeg
    print(p)
    let output = try p.runForStdout()
    print("OUTPUT START\n\(output)\nOUTPUT END")
} catch {
    print(error.localizedDescription)
}
