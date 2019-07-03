import Foundation
import Proc

let ls = Proc("/usr/bin/env", "find", ".", "-type", "f")
let sort = Proc("/usr/bin/sort", "-rh")
let wc = Proc("/usr/bin/xargs", "wc", "-c")

do {
    let output = try ls
        .pipe(to: wc)
        .pipe(to: sort)
        .runForStdout()
    print("OUTPUT START\n\(output)\nOUTPUT END")
} catch {
    print(error.localizedDescription)
}
