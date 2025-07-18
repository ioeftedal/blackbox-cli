// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "blackbox-cli",
    platforms: [.macOS(.v26)],
    products: [
        .executable(name: "blackbox-cli", targets: ["blackbox-cli"])
    ],
    targets: [
        .executableTarget(
            name: "blackbox-cli",
            dependencies: []
        )
    ]
)
