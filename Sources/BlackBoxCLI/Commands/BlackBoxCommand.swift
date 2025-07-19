import ArgumentParser
import Foundation
import FoundationModels

@main
struct BlackBoxCLI: AsyncParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "blackbox",
        abstract: "A CLI tool for managing blackbox sessions with language models",
        version: "0.1.0"
    )

    @Option(name: [.short, .long], help: "Path to a text file to process")
    var file: String?

    @Flag(name: [.short, .long], help: "Run in interactive chat mode")
    var interactive = false

    mutating func run() async throws {
        let cliSession = CLISession()

        if let filePath = file {
            try await processFile(filePath)
            return
        }
        // We default to chatLoop
        try await cliSession.chatLoop()
    }

    private func processFile(_ path: String) async throws {
        guard isTxtFile(path: path) else {
            let fileExtension = URL(fileURLWithPath: path).pathExtension
            throw BlackBoxError.invalidFileType(
                expected: "txt", found: fileExtension.isEmpty ? "none" : fileExtension)
        }

        let content = try readTextFile(from: path)

        print("Processing file: \(path)")
        print("Unimplmeneted")
    }
}
