import Foundation

public enum BlackBoxError: LocalizedError {
    case invalidFileType(expected: String, found: String)
    case fileNotFound(path: String)
    case fileReadError(path: String, underlying: Error)
    case sessionError(Error)
    case invalidInput(String)
    
    public var errorDescription: String? {
        switch self {
        case .invalidFileType(let expected, let found):
            return "Invalid file type. Expected \(expected) but found \(found)"
        case .fileNotFound(let path):
            return "File not found at path: \(path)"
        case .fileReadError(let path, let error):
            return "Failed to read file at \(path): \(error.localizedDescription)"
        case .sessionError(let error):
            return "Language model session error: \(error.localizedDescription)"
        case .invalidInput(let message):
            return "Invalid input: \(message)"
        }
    }
}