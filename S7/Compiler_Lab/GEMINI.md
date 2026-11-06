# Compiler Lab Workspace Guidelines

## Environment & Remote Execution (SSH)
- **Host Architecture**: This project resides on a remote Linux machine (`wolf@192.168.31.100`), mapped locally to Windows drive `Z:` (`//192.168.31.100/RootFS/home/wolf/...`).
- **Toolchain**: Do NOT attempt to run `gcc`, `flex`, or `bison` locally via Windows / MSYS2 paths (which encounter sandbox and IPC permission errors).
- **Execution Protocol**: Always execute all build, compilation, test, and verification commands remotely via SSH:
  ```bash
  ssh wolf@192.168.31.100 "cd ~/Documents/BTech_Journey/S7/Compiler_Lab/<experiment_folder> && <command>"
  ```
- Passwordless authentication is configured for `wolf@192.168.31.100`.

## Code Structure & Quality Standards
- **Folder Organization**: Every experiment must be self-contained in its own dedicated directory (e.g. `Exp01_Lexical_Analyzer_C`, `Exp02_...`).
- **Simplicity First**: Write clean, standard ANSI C / Lex / Yacc code that is as simple as possible while fulfilling all syllabus requirements.
- **Header Algorithm**: Every source file (`.c`, `.l`, `.y`) must begin with a clear, step-by-step numbered algorithm in block comments (`/* ... */`).
- **Footer Sample Output**: Every source file must conclude with actual, verified sample terminal outputs in comments at the bottom.
- **Documentation**: Maintain a root `README.md` indexing all experiments with concise compilation and run instructions.
