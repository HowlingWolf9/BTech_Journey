# Compiler Design Laboratory (S7 B.Tech)

This repository contains implementations of all 16 experiments in the Compiler Design Lab syllabus organized folder-by-folder across three cycles. Each experiment is implemented in simple, standard C / Lex / Yacc code, includes a concise algorithm at the top in comments, and includes verified sample execution outputs at the bottom in comments.

---

## Table of Contents & Syllabus

### CYCLE I: Lexical Analysis Basics
- **[Exp01_Lexical_Analyzer_C](./Exp01_Lexical_Analyzer_C)**: Implementation of Lexical Analyzer using C
- **[Exp02_Lexical_Analyzer_Lex](./Exp02_Lexical_Analyzer_Lex)**: Implementation of Lexical Analyzer using LEX
- **[Exp03_Words_Lines_Chars_Lex](./Exp03_Words_Lines_Chars_Lex)**: LEX Program to display number of words, lines, and characters
- **[Exp04_Convert_Substring_abc](./Exp04_Convert_Substring_abc)**: LEX Program to convert substring `abc` to `ABC`
- **[Exp05_Vowels_Consonants_Lex](./Exp05_Vowels_Consonants_Lex)**: LEX Program to find number of vowels and consonants

### CYCLE II: Parser Generators (YACC / Bison)
- **[Exp06_Valid_Arithmetic_Expression_Yacc](./Exp06_Valid_Arithmetic_Expression_Yacc)**: YACC specification to recognize valid arithmetic expression
- **[Exp07_Valid_Identifier_Yacc](./Exp07_Valid_Identifier_Yacc)**: YACC specification to recognize valid identifier
- **[Exp08_Calculator_Lex_Yacc](./Exp08_Calculator_Lex_Yacc)**: Implementation of a calculator using LEX and YACC

### CYCLE III: Grammar Analysis, Parsing & Code Generation
- **[Exp09_Epsilon_Closure](./Exp09_Epsilon_Closure)**: Find $\epsilon$-closure of all states of any given NFA with $\epsilon$-transitions
- **[Exp10_First](./Exp10_First)**: Find FIRST set of any given grammar
- **[Exp11_Follow](./Exp11_Follow)**: Find FOLLOW set of any given grammar
- **[Exp12_Recursive_Descent_Parser](./Exp12_Recursive_Descent_Parser)**: Recursive Descent Parser for arithmetic expressions
- **[Exp13_Shift_Reduce_Parser](./Exp13_Shift_Reduce_Parser)**: Shift-Reduce Parser with stack/input/action trace
- **[Exp14_Constant_Propagation](./Exp14_Constant_Propagation)**: Code optimization via Constant Propagation and Folding
- **[Exp15_Intermediate_Code_Generation](./Exp15_Intermediate_Code_Generation)**: Intermediate Three-Address Code (TAC) and Quadruple table generation
- **[Exp16_Target_Code_Generation](./Exp16_Target_Code_Generation)**: Target machine code (Assembly) generation from TAC

### EXTRA: Continuous Evaluation LEX Programs
- **[Extra_LEX_Programms](./Extra_LEX_Programms)**: Additional 14 LEX programs covering Set 1 and Set 2 (simple/compound sentences, word operations, numerical processing, palindrome, Armstrong numbers, password validation, etc.)

### EASY / EXAM VERSIONS: Ultra-Concise Minimum-Lines Implementations
- **[Easy_Versions](./Easy_Versions)**: Ultra-concise, exam-friendly versions of all 30 programs (Exp01–Exp16 and Extra LEX Set 1 & Set 2) designed for quick handwriting on paper, stripped of defensive bloat while preserving full lab-manual standard algorithms and verified output footers.

---

## Compilation & Run Commands

### Cycle I
1. **Exp01 - Lexical Analyzer in C**:
   ```bash
   cd Exp01_Lexical_Analyzer_C
   gcc lexical_analyzer.c -o lexical_analyzer
   ./lexical_analyzer input.c
   ```
2. **Exp02 - Lexical Analyzer in Lex**:
   ```bash
   cd Exp02_Lexical_Analyzer_Lex
   flex lexical_analyzer.l
   gcc lex.yy.c -o lexical_analyzer
   ./lexical_analyzer input.c
   ```
3. **Exp03 - Words, Lines, Characters**:
   ```bash
   cd Exp03_Words_Lines_Chars_Lex
   flex count.l
   gcc lex.yy.c -o count
   ./count
   ```
4. **Exp04 - Substring Replacement (abc -> ABC)**:
   ```bash
   cd Exp04_Convert_Substring_abc
   flex replace_abc.l
   gcc lex.yy.c -o replace_abc
   ./replace_abc
   ```
5. **Exp05 - Vowels and Consonants**:
   ```bash
   cd Exp05_Vowels_Consonants_Lex
   flex vowels_consonants.l
   gcc lex.yy.c -o vowels_consonants
   ./vowels_consonants
   ```

### Cycle II
6. **Exp06 - Valid Arithmetic Expression**:
   ```bash
   cd Exp06_Valid_Arithmetic_Expression_Yacc
   bison -d -y expr.y
   flex expr.l
   gcc y.tab.c lex.yy.c -o expr
   ./expr
   ```
7. **Exp07 - Valid Identifier**:
   ```bash
   cd Exp07_Valid_Identifier_Yacc
   bison -d -y identifier.y
   flex identifier.l
   gcc y.tab.c lex.yy.c -o identifier
   ./identifier
   ```
8. **Exp08 - Calculator using Lex & Yacc**:
   ```bash
   cd Exp08_Calculator_Lex_Yacc
   bison -d -y calc.y
   flex calc.l
   gcc y.tab.c lex.yy.c -o calc
   ./calc
   ```

### Cycle III
9. **Exp09 - Epsilon Closure**:
   ```bash
   cd Exp09_Epsilon_Closure
   gcc epsilon_closure.c -o epsilon_closure
   ./epsilon_closure
   ```
10. **Exp10 - FIRST of Grammar**:
    ```bash
    cd Exp10_First
    gcc first.c -o first
    ./first
    ```
11. **Exp11 - FOLLOW of Grammar**:
    ```bash
    cd Exp11_Follow
    gcc follow.c -o follow
    ./follow
    ```
12. **Exp12 - Recursive Descent Parser**:
    ```bash
    cd Exp12_Recursive_Descent_Parser
    gcc recursive_descent_parser.c -o recursive_descent_parser
    ./recursive_descent_parser
    ```
13. **Exp13 - Shift Reduce Parser**:
    ```bash
    cd Exp13_Shift_Reduce_Parser
    gcc shift_reduce_parser.c -o shift_reduce_parser
    ./shift_reduce_parser
    ```
14. **Exp14 - Constant Propagation**:
    ```bash
    cd Exp14_Constant_Propagation
    gcc constant_propagation.c -o constant_propagation
    ./constant_propagation
    ```
15. **Exp15 - Intermediate Code Generation**:
    ```bash
    cd Exp15_Intermediate_Code_Generation
    gcc intermediate_code_gen.c -o intermediate_code_gen
    ./intermediate_code_gen
    ```
16. **Exp16 - Target Code Generation**:
    ```bash
    cd Exp16_Target_Code_Generation
    gcc target_code_gen.c -o target_code_gen
    ./target_code_gen
    ```

### Extra LEX Programs
Refer to **[Extra_LEX_Programms/README.md](./Extra_LEX_Programms/README.md)** for individual instructions for all 14 programs across Set 1 and Set 2.
To compile and test all 14 extra programs in a single step:
```bash
cd Extra_LEX_Programms
bash build_and_test.sh
```

