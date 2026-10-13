PROJECTS_X64 := $(notdir $(wildcard src/x64/*))
PROJECTS_X86 := $(notdir $(wildcard src/x86/*))
TARGETS_X64 := $(addprefix x64/,$(PROJECTS_X64))
TARGETS_X86 := $(addprefix x86/,$(PROJECTS_X86))
LIBS_X64 := $(wildcard libraries/x64/*.lib)
LIBS_X86 := $(wildcard libraries/x86/*.lib)

STUB_X64 := build/pdbid64.obj
STUB_X86 := build/pdbid.obj

$(STUB_X64): tools/pdbid.c
	@mkdir -p build
	clang-cl --target=x86_64-pc-windows-msvc /Zl -Z7 -c $< -o $@

$(STUB_X86): tools/pdbid.c
	@mkdir -p build
	clang-cl --target=i686-pc-windows-msvc /Zl -Z7 -c $< -o $@

all: x64 x86

x64: $(TARGETS_X64)

x86: $(TARGETS_X86)

x64/%: $(STUB_X64)
	@mkdir -p build/x64
	@wine tools/ml64.exe /nologo /c /Cp /Zi /Zf /Fo build/x64/$*.obj src/x64/$*/main.asm
	lld-link /nologo /machine:x64 /subsystem:console /entry:main /debug \
		/ignore:4099 /pdb:build/x64/$*.pdb /out:build/x64/$*.exe build/x64/$*.obj $(STUB_X64) $(LIBS_X64)

x86/%: $(STUB_X86)
	@mkdir -p build/x86
	@wine tools/ml.exe /nologo /c /coff /Cp /Zi /Zf /Fo build/x86/$*.obj src/x86/$*/main.asm
	lld-link /nologo /machine:x86 /safeseh:no /subsystem:console /entry:main /debug \
		/ignore:4099 /pdb:build/x86/$*.pdb /out:build/x86/$*.exe build/x86/$*.obj $(STUB_X86) $(LIBS_X86)

run-x64/%: x64/%
	@echo
	@wine build/x64/$*.exe

run-x86/%: x86/%
	@echo
	@wine build/x86/$*.exe

debug-x64/%: x64/%
	@echo
	@winedbg --gdb --no-start --port 12345 build/x64/$*.exe

debug-x86/%: x86/%
	@echo
	@winedbg --gdb --no-start --port 12345 build/x86/$*.exe

clean:
	rm -rf build

.PHONY: all x64 x86 clean run-x64/% run-x86/% debug-x64/% debug-x86/%
