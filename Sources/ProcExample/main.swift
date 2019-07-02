import Foundation
import Proc

let ls = Proc("/bin/ls")
let sort = Proc("/usr/bin/sort", "-r")
let wc = Proc("/usr/bin/xargs", "wc", "-c")

let output = ls
    .pipe(to: sort)
    .pipe(to: wc)
    .runForStdout()
print("OUTPUT START\n\(output)\nOUTPUT END")

