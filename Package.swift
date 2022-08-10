// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "Shuttle",
    platforms: [
        .iOS(.v13),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "Shuttle",
            targets: [
                "Shuttle"
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
        .executableTarget(
            name: "playground",
            dependencies: [
                "Shuttle",
                .product(name: "ConsoleKit", package: "console-kit"),
            ],
            path: "Example/CLI"
        ),
        .target(
            name: "Shuttle",
            dependencies: [
                "Get",
                "URLQueryEncoder",
            ],
            exclude: [
                "OpenAPI/app_store_connect_api_2.0_openapi.json"
            ]
        ),
        .testTarget(
            name: "ShuttleTests",
            dependencies: [
                "Shuttle",
                "Mocker",
            ]
        ),
    ]
)
