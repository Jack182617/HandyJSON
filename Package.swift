// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "HandyJSON",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .tvOS(.v12),
        .watchOS(.v4)
    ],
    products: [
        .library(name: "HandyJSON", targets: ["HandyJSON"])
    ],
    targets: [
        .target(
            name: "HandyJSON",
            path: "Source",
            exclude: [
                "LICENSE",
                "Info-iOS.plist",
                "Info-macOS.plist",
                "Info-tvOS.plist",
                "Info-watchOS.plist"
            ]
        ),
        .testTarget(
            name: "HandyJSONTests",
            dependencies: ["HandyJSON"],
            path: "Tests/HandyJSONTests",
            exclude: [
                "Info-iOS.plist",
                "Info-macOS.plist",
                "Info-tvOS.plist"
            ]
        )
    ],
    swiftLanguageVersions: [.v5]
)
