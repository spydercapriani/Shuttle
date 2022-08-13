// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Shuttle",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "shuttle",
            targets: [
                "ShuttleTool"
            ]
        ),
        .library(
            name: "Shuttle",
            targets: [
//                "Shuttle",
                "ProvisioningAPI"
            ]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kean/Get.git", from: "1.0.0"),
        .package(url: "https://github.com/CreateAPI/URLQueryEncoder.git", from: "0.2.0"),
        .package(url: "https://github.com/WeTransfer/Mocker.git", from: "2.3.0"),
        .package(url: "https://github.com/vapor/console-kit.git", from: "4.4.1"),
    ],
    targets: [
        // MARK: - Shuttle Library
        .target(
            name: "Shuttle",
            dependencies: [
                "Get",
                "URLQueryEncoder",
            ]
        ),
        
        // MARK: - Shuttle Tests
//        .testTarget(
//            name: "ShuttleTests",
//            dependencies: [
//                "Shuttle",
//                "Mocker",
//            ]
//        ),
        
        // MARK: - Shuttle CLI Tool
        .executableTarget(
            name: "ShuttleTool",
            dependencies: [
                "ProvisioningTools",
                .product(name: "ConsoleKit", package: "console-kit"),
            ]
        ),
        
        .target(
            name: "ProvisioningAPI",
            dependencies: [
                "Shuttle"
            ]
        ),
        
        // MARK: - Provisioning Tool
        .target(
            name: "ProvisioningTools",
            dependencies: [
                "ProvisioningAPI"
            ]
        ),
        
    ]
)
