name = keyboard
prefix ?= $(HOME)/.local
bindir = $(prefix)/bin

build:
	swift build

run: build
	swift run $(name) get

release:
	swift build --configuration release --disable-sandbox --arch arm64

install: release
	install -d "$(bindir)"
	install ".build/release/$(name)" "$(bindir)"

uninstall:
	rm -rf "$(bindir)/$(name)"

clean:
	rm -rf .build

.PHONY: build install uninstall clean release
