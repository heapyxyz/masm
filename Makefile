WINE ?= @wine

PROJECTS_X64 := $(notdir $(wildcard src/x64/*))
PROJECTS_X86 := $(notdir $(wildcard src/x86/*))
TARGETS_X64 := $(addprefix x64/,$(PROJECTS_X64))
TARGETS_X86 := $(addprefix x86/,$(PROJECTS_X86))

all: x64 x86

x64: $(TARGETS_X64)

x86: $(TARGETS_X86)

x64/%:
	@mkdir -p build/x64/$*
	jwasm -win64 -Fo build/x64/$*/main.obj src/x64/$*/main.asm
	lld-link /nologo /machine:x64 /subsystem:console /entry:main \
		/out:build/x64/$*/main.exe build/x64/$*/main.obj libraries/x64/kernel32.Lib

x86/%:
	@mkdir -p build/x86/$*
	jwasm -coff -Fo build/x86/$*/main.obj src/x86/$*/main.asm
	lld-link /nologo /machine:x86 /safeseh:no /subsystem:console /entry:main \
		/out:build/x86/$*/main.exe build/x86/$*/main.obj libraries/x86/kernel32.Lib

run-x64/%: x64/%
	@echo
	$(WINE) build/x64/$*/main.exe

run-x86/%: x86/%
	@echo
	$(WINE) build/x86/$*/main.exe

clean:
	rm -rf build

.PHONY: all x64 x86 clean run-x64/% run-x86/%
