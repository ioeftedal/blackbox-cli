// swift-tools-version:6.2
import PackageDescription

let package = Package(
    name: "blackbox-cli",
    platforms: [.macOS(.v26)],
    products: [
        .executable(name: "blackbox-cli", targets: ["blackbox-cli"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.6.1")

    ],
    targets: [
        .executableTarget(
            name: "blackbox-cli",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")

            ]
        )
    ]
)
