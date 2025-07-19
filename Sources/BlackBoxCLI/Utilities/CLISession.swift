import Foundation
import FoundationModels
import NaturalLanguage

struct BlackBox {

    init() {
    }

}

public struct CLISession {
    private let languageModelSession: LanguageModelSession
    private var embedder: NLEmbedding

    public init() {
        self.embedder = NLEmbedding.sentenceEmbedding(for: .english)!
        self.languageModelSession = LanguageModelSession()
    }

    func embeddWord(word: String) -> [Double] {
        let vec = embedder.vector(for: word)!
        return vec
    }

    public func chatLoop() async throws {

        while true {
            print("\n> ", terminator: "")
            fflush(stdout)

            guard let input = readLine() else {
                break
            }

            let trimmedInput = input.trimmingCharacters(in: .whitespacesAndNewlines)

            if trimmedInput == "/q" {
                print("Goodbye!")
                break
            }

            if !trimmedInput.isEmpty {
                do {
                    //Flow:
                    // Embedd word
                    // Lookup in db
                    // Feed both prompt and context into model.
                    let response = try await languageModelSession.respond(to: trimmedInput)
                    print("\n >> \(response.content)")
                } catch {
                    print("\nError: \(error.localizedDescription)")
                }
            }
        }
    }

}

// MARK: - File Utilities

public func isTxtFile(path: String) -> Bool {
    return path.lowercased().hasSuffix(".txt")
}

public func readTextFile(from path: String) throws -> String {
    let url = URL(fileURLWithPath: path)

    guard FileManager.default.fileExists(atPath: path) else {
        throw BlackBoxError.fileNotFound(path: path)
    }

    do {
        return try String(contentsOf: url, encoding: .utf8)
    } catch {
        throw BlackBoxError.fileReadError(path: path, underlying: error)
    }
}
