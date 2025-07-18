import Foundation

// Check if path points to a .txt file
func isTxtFile(_ path: String) -> Bool {
    return path.lowercased().hasSuffix(".txt")
}

// Read text from file path
func readTextFile(at path: String) -> String? {
    do {
        return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
        print("Failed to read file: \(error)")
        return nil
    }
}

// CLI entrypoint
func cliApplication() {
    let args = CommandLine.arguments

    guard args.count > 1 else {
        print("Usage: ./storeNote \"note text\" OR ./storeNote path/to/note.txt")
        exit(1)
    }

    let input = args[1]
    var noteContent: String?
    var source: String = "CLI"

    if isTxtFile(input) {
        if let content = readTextFile(at: input) {
            noteContent = content
            source = URL(fileURLWithPath: input).lastPathComponent
        } else {
            print("Could not read .txt file.")
            exit(1)
        }
    } else {
        noteContent = input
    }

    guard let note = noteContent else {
        print("No valid note content provided.")
        exit(1)
    }

    print(note)
}
