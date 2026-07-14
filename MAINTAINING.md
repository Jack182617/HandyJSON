# Maintaining HandyJSON

This branch is based on Alibaba HandyJSON `5.0.4-beta` and includes the
Xcode 15/16 compatibility commits from the Miles-Matheson fork, plus current
Swift runtime compatibility fixes.

## Runtime boundary

HandyJSON depends on Swift reflection metadata, Swift runtime entry points, and
direct writes to model memory. It is therefore coupled to the Swift ABI and
must be treated as runtime-sensitive infrastructure rather than a normal JSON
utility library.

When upgrading Xcode or Swift, run all of the following before publishing:

```sh
swift test
xcodebuild test -project HandyJSON.xcodeproj \
  -scheme 'HandyJSON iOS Tests' \
  -destination 'platform=iOS Simulator,id=<available-simulator-id>'
xcodebuild test -project HandyJSON.xcodeproj \
  -scheme 'HandyJSON macOS Tests' \
  -destination 'platform=macOS'
```

The UIKit inheritance tests are important: they cover field offsets for Swift
classes rooted in Objective-C classes and for another Swift subclass above
that root. Also build the iOS and macOS Release frameworks. Build tvOS and
watchOS when those SDKs are installed.

## Distribution checklist

Before creating a release:

1. Set `s.homepage` and `s.source` in `HandyJSON.podspec` to the maintained
   repository. The current podspec still points to Alibaba intentionally until
   the final repository URL is known.
2. Bump the package version and create a matching Git tag.
3. Verify Swift Package Manager and CocoaPods from clean checkouts; do not
   assume that a CocoaPods `:git` URL overrides a podspec whose `s.source`
   points elsewhere.
4. Record the Xcode/Swift version and the supported deployment targets in the
   release notes.
