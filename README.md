# masm

My MASM projects made for uni with an easy-to-use and awesome Makefile.

## Why?

At my university we're learning MASM and there's no easy way to get Visual Studio working on Linux/macOS - VMs are laggy, WinBoat is in beta (lots of visual bugs, heavy apps are unusable) and obviously I won't install Windows just for that. This repository makes it easy to compile and run x86/x64 MASM projects in Visual Studio Code, NeoVim or any other Linux/macOS dev environment.

## How?

Makefile uses JWasm with optimized flags to compile (most compatible with Windows API) executables. Then, libraries from `libraries/[ARCHITECTURE]/` folder are linked (using `lld-link` command) so your project runs without any Windows API issues.

## Requirements

- [Wine](https://winehq.org)
- [JWasm](https://github.com/Baron-von-Riedesel/JWasm) (most likely you'll have to build it yourself)
- `make`
- `lld`

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

> [!IMPORTANT]  
> Debugging MASM executables isn't currently supported, however I plan on adding it soon.

## Licensing

This repository uses MIT license. If you want to use my stuff in your repositories, please don't forget about giving me credit.
