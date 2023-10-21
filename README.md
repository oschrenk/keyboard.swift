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

## Installation

**Via Github**

```
git clone git@github.com:oschrenk/keyboard.swift.git
cd keyboard.swift

# installs to $(HOME)/.local/bin/keyboard
make install
```

## Development

**Dependencies**

```
brew install swiftlint
```

- **Build** `make build`
- **Run** `make run`

## Release

```
make release
# produces artifact in in ./.build/release/keyboard
```
