WINE ?= @wine

PROJECTS_X64 := $(notdir $(wildcard src/x64/*))
PROJECTS_X86 := $(notdir $(wildcard src/x86/*))
TARGETS_X64 := $(addprefix x64/,$(PROJECTS_X64))
TARGETS_X86 := $(addprefix x86/,$(PROJECTS_X86))
LIBS_X64 := $(wildcard libraries/x64/*.lib)
LIBS_X86 := $(wildcard libraries/x86/*.lib)

all: x64 x86

x64: $(TARGETS_X64)

x86: $(TARGETS_X86)

x64/%:
	@mkdir -p build/x64
	jwasm -win64 -Zg -Zne -Zv8 -Cp -Fo build/x64/$*.obj src/x64/$*/main.asm
	lld-link /nologo /machine:x64 /subsystem:console /entry:main \
		/out:build/x64/$*.exe build/x64/$*.obj $(LIBS_X64)

x86/%:
	@mkdir -p build/x86
	jwasm -coff -Zg -Zne -Zv8 -Cp -Fo build/x86/$*.obj src/x86/$*/main.asm
	lld-link /nologo /machine:x86 /safeseh:no /subsystem:console /entry:main \
		/out:build/x86/$*.exe build/x86/$*.obj $(LIBS_X86)

run-x64/%: x64/%
	@echo
	$(WINE) build/x64/$*.exe

run-x86/%: x86/%
	@echo
	$(WINE) build/x86/$*.exe

clean:
	rm -rf build

.PHONY: all x64 x86 clean run-x64/% run-x86/%
