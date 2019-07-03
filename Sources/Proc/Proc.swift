import Foundation

public final class Proc {
    
    private var _process: Process
    
    private var next: Proc? = nil
    private var last: Proc { next?.last ?? self }
    
    public convenience init(_ command: String, _ args: String...) {
        self.init(command, args)
    }
    
    public init(_ command: String, _ args: [String]) {
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
        try runRecursively()
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return String(data: data, encoding: .utf8)!
    }
    
    fileprivate func runRecursively() throws {
        try _process.run()
        try next?.runRecursively()
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


