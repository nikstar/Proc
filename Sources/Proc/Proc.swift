import Foundation

public final class Proc {
    
    private var _process: Process
    
    private var next: Proc? = nil
    private var last: Proc { next?.last ?? self }
    
    public convenience init(_ path: String, _ args: String...) {
        self.init(path, args)
    }
    
    public init(_ path: String, _ args: [String]) {
        _process = Process()
        _process.executableURL = URL(fileURLWithPath: command)
        _process.arguments = args
    }
    
    public init(_ process: Process) {
        _process = process
    }
    
    public func runForStdout() throws -> String {
        let pipe = Pipe()
        last._process.standardOutput = pipe
        try run()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)!
    }
    
    public func run() throws {
        try _process.run()
        try next?.run()
    }
    
    public func waitUntilExit() {
        _process.waitUntilExit()
        next?.waitUntilExit()
    }
    
    public func pipe(to: Proc) -> Proc {
        let currentLast = last
        let newLast = to
        
        currentLast.next = newLast
        let pipe = Pipe()
        currentLast._process.standardOutput = pipe
        newLast._process.standardInput = pipe
        
        return self
    }
}

extension Proc : CustomStringConvertible {
    public var description: String {
        let path = _process.executableURL?.path ?? "_"
        let args = _process.arguments ?? []
        var description = "Proc{ \(path) \(args)"
        if let next = next {
            description += " => \(next.description)"
        }
        description += " }"
        return description
    }
}

extension Proc {
    convenience init(name: String, _ args: String...) {
        self.init(name: name, args)
    }
    
    convenience init(name: String, _ args: [String]) {
        self.init("/usr/bin/env", [name] + args)
        _process.environment = ProcessInfo.processInfo.environment
        _process.environment!["PATH"]! = "/usr/local/bin:" + _process.environment!["PATH"]!
    }
}
