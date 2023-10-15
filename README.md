# README

A macOS tool to read and control keyboard brightness

## Usage

Print out current settings

```
$ keyboard
Auto Brightness enabled: true
Idle Dim Time: 30.0
Brightness: 0.5
```

Configure

```
# set one or more
keyboard set --idle-dim-time 0.5 --brightness 0.5 --auto-brightness true
```

## Development

**Dependencies**

```
brew install swiftlint
```

**Compile and run**

```
swift build
swift run keyboard get
```

## Release

```
swift build -c release --arch arm64
# artifact produced in ./.build/release/keyboard
```
