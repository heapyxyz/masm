# masm

My MASM projects made for uni with an easy-to-use and awesome Makefile.

## Why?

At my university we're learning MASM and there's no easy way to get Visual Studio working on Linux/macOS - VMs are laggy, WinBoat is in beta (lots of visual bugs, heavy apps are unusable) and obviously I won't install Windows just for that. This repository makes it easy to compile and run x86/x64 MASM projects in Visual Studio Code, NeoVim or any other Linux/macOS dev environment.

## Requirements

- [Wine](https://winehq.org)
- `make`
- `lld`
- `clang`

## Setting Up

### Initialization

`[ARCHITECTURE]` = either `x86` or `x64`.

Create `src/[ARCHITECTURE]/[PROJECT_NAME]/` folder with `main.asm` file inside it. Make sure your entry point is defined in `main.asm`!

### Compiling

To compile a specific project, use:

```bash
make [ARCHITECTURE]/[PROJECT_NAME]
```

To compile all projects for a specific architecture, use:

```bash
make [ARCHITECTURE]
```

To compile all projects for both architectures, use:

```bash
make all
```

### Running

To run your project, use:

```bash
make run-[ARCHITECTURE]/[PROJECT_NAME]
```

If you haven't compiled your project before running, Makefile will do that for you.

### Cleanup

To cleanup your builds, either delete `build/` folder manually or use:

```bash
make clean
```

### Debugging

Debugging is done via `winedbg`. This repository currently contains a ready-to-use VS Code configuration which debugs the project you're currently viewing. If it doesn't have a `main.asm` file, the debugger will fail.

If you want to debug through VS Code, make sure you have [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb) extension installed.

To debug your project manually, use:

```bash
make debug-[ARCHITECTURE]/[PROJECT_NAME]
```

Then connect to the `gdb` session hosted @ `localhost:12345`.

## Licensing

This repository uses MIT license. If you want to use my stuff in your repositories, please don't forget about giving me credit.
