# Compiler Design Lab - Ultra-Concise Exam/Lab Easy Versions

This directory contains ultra-concise, exam-friendly versions of all 30 Compiler Design Lab programs (Exp01–Exp16 and 14 Continuous Evaluation LEX programs across Set 1 & Set 2).

### Design Philosophy
- **Prioritize Minimum Lines of Code**: Formatted for quick handwriting during lab exams and university viva.
- **Idiomatic C & Lex Conciseness**: Standard library routines (`strchr`, `sscanf`, `ctype` functions), compact loops, and one-liner Lex rules (`pattern { action; }`).
- **Pure Happy Path**: Omission of defensive boilerplate (no `argc` checks, `NULL` checks, or division-by-zero checks).
- **Detailed Algorithm Header**: Every file begins with a step-by-step numbered algorithm matching university lab manual standards.
- **Sample Output Footer**: Every file ends with verified actual terminal output in comments.

---

## Index of Programs

### CYCLE I: Lexical Analysis
| No | Experiment | Directory | Source File | Run Command |
|---|---|---|---|---|
| 01 | Lexical Analyzer in C | `Exp01_Lexical_Analyzer_C` | `lexical_analyzer.c` | `gcc lexical_analyzer.c -o lexical_analyzer && ./lexical_analyzer` |
| 02 | Lexical Analyzer in LEX | `Exp02_Lexical_Analyzer_Lex` | `lexical_analyzer.l` | `flex lexical_analyzer.l && gcc lex.yy.c -o lexical_analyzer && ./lexical_analyzer` |
| 03 | Words, Lines, Characters | `Exp03_Words_Lines_Chars_Lex` | `count.l` | `flex count.l && gcc lex.yy.c -o count && ./count` |
| 04 | Substring abc -> ABC | `Exp04_Convert_Substring_abc` | `replace_abc.l` | `flex replace_abc.l && gcc lex.yy.c -o replace_abc && ./replace_abc` |
| 05 | Vowels & Consonants | `Exp05_Vowels_Consonants_Lex` | `vowels_consonants.l` | `flex vowels_consonants.l && gcc lex.yy.c -o vowels_consonants && ./vowels_consonants` |

### CYCLE II: Parser Generators (YACC / Bison)
| No | Experiment | Directory | Source Files | Run Command |
|---|---|---|---|---|
| 06 | Valid Arithmetic Expression | `Exp06_Valid_Arithmetic_Expression_Yacc` | `expr.l`, `expr.y` | `yacc -d expr.y && flex expr.l && gcc y.tab.c lex.yy.c -o expr && ./expr` |
| 07 | Valid Identifier | `Exp07_Valid_Identifier_Yacc` | `identifier.l`, `identifier.y` | `yacc -d identifier.y && flex identifier.l && gcc y.tab.c lex.yy.c -o identifier && ./identifier` |
| 08 | Calculator using Lex & Yacc | `Exp08_Calculator_Lex_Yacc` | `calc.l`, `calc.y` | `yacc -d calc.y && flex calc.l && gcc y.tab.c lex.yy.c -o calc && ./calc` |

### CYCLE III: Grammar Analysis, Parsing & Code Generation
| No | Experiment | Directory | Source File | Run Command |
|---|---|---|---|---|
| 09 | Epsilon Closure of NFA | `Exp09_Epsilon_Closure` | `epsilon_closure.c` | `gcc epsilon_closure.c -o epsilon_closure && ./epsilon_closure` |
| 10 | FIRST of Grammar | `Exp10_First` | `first.c` | `gcc first.c -o first && ./first` |
| 11 | FOLLOW of Grammar | `Exp11_Follow` | `follow.c` | `gcc follow.c -o follow && ./follow` |
| 12 | Recursive Descent Parser | `Exp12_Recursive_Descent_Parser` | `recursive_descent_parser.c` | `gcc recursive_descent_parser.c -o recursive_descent_parser && ./recursive_descent_parser` |
| 13 | Shift Reduce Parser | `Exp13_Shift_Reduce_Parser` | `shift_reduce_parser.c` | `gcc shift_reduce_parser.c -o shift_reduce_parser && ./shift_reduce_parser` |
| 14 | Constant Propagation & Folding | `Exp14_Constant_Propagation` | `constant_propagation.c` | `gcc constant_propagation.c -o constant_propagation && ./constant_propagation` |
| 15 | Intermediate Code Generation | `Exp15_Intermediate_Code_Generation` | `intermediate_code_gen.c` | `gcc intermediate_code_gen.c -o intermediate_code_gen && ./intermediate_code_gen` |
| 16 | Target Code Generation | `Exp16_Target_Code_Generation` | `target_code_gen.c` | `gcc target_code_gen.c -o target_code_gen && ./target_code_gen` |

### EXTRA: Continuous Evaluation LEX Programs (Set 1)
| No | Experiment | Directory | Source File | Run Command |
|---|---|---|---|---|
| 17 | Simple / Compound Sentence | `Extra_LEX_Programms/Set1_01_Simple_Compound_Sentence` | `simple_compound.l` | `flex simple_compound.l && gcc lex.yy.c -o simple_compound && ./simple_compound` |
| 18 | Reverse Word | `Extra_LEX_Programms/Set1_02_Reverse_Word` | `reverse_word.l` | `flex reverse_word.l && gcc lex.yy.c -o reverse_word && ./reverse_word` |
| 19 | Largest of Three Numbers | `Extra_LEX_Programms/Set1_03_Largest_Three_Numbers` | `largest_three.l` | `flex largest_three.l && gcc lex.yy.c -o largest_three && ./largest_three` |
| 20 | Count Words (Length 5 to 10) | `Extra_LEX_Programms/Set1_04_Count_Words_Len_5_to_10` | `count_words_5_to_10.l` | `flex count_words_5_to_10.l && gcc lex.yy.c -o count_words_5_to_10 && ./count_words_5_to_10` |
| 21 | Character Frequency | `Extra_LEX_Programms/Set1_05_Char_Frequency` | `char_frequency.l` | `flex char_frequency.l && gcc lex.yy.c -o char_frequency && ./char_frequency` |
| 22 | Longest Word Length | `Extra_LEX_Programms/Set1_06_Longest_Word_Length` | `longest_word.l` | `flex longest_word.l && gcc lex.yy.c -o longest_word && ./longest_word` |
| 23 | String Starting with Vowel | `Extra_LEX_Programms/Set1_07_String_Starting_Vowel` | `starting_vowel.l` | `flex starting_vowel.l && gcc lex.yy.c -o starting_vowel && ./starting_vowel` |
| 24 | Count Pos/Neg Int & Float | `Extra_LEX_Programms/Set1_08_Count_Pos_Neg_Int_Float` | `count_pos_neg.l` | `flex count_pos_neg.l && gcc lex.yy.c -o count_pos_neg && ./count_pos_neg` |

### EXTRA: Continuous Evaluation LEX Programs (Set 2)
| No | Experiment | Directory | Source File | Run Command |
|---|---|---|---|---|
| 25 | Palindrome Word | `Extra_LEX_Programms/Set2_01_Palindrome_Word` | `palindrome.l` | `flex palindrome.l && gcc lex.yy.c -o palindrome && ./palindrome` |
| 26 | Fibonacci Series | `Extra_LEX_Programms/Set2_02_Fibonacci_Series` | `fibonacci.l` | `flex fibonacci.l && gcc lex.yy.c -o fibonacci && ./fibonacci` |
| 27 | Even/Odd & Factorial | `Extra_LEX_Programms/Set2_03_Even_Odd_Factorial` | `even_odd_factorial.l` | `flex even_odd_factorial.l && gcc lex.yy.c -o even_odd_factorial && ./even_odd_factorial` |
| 28 | Armstrong Number | `Extra_LEX_Programms/Set2_04_Armstrong_Number` | `armstrong.l` | `flex armstrong.l && gcc lex.yy.c -o armstrong && ./armstrong` |
| 29 | Sum of Digits | `Extra_LEX_Programms/Set2_05_Sum_Of_Digits` | `sum_of_digits.l` | `flex sum_of_digits.l && gcc lex.yy.c -o sum_of_digits && ./sum_of_digits` |
| 30 | Password Validation | `Extra_LEX_Programms/Set2_06_Password_Validation` | `password_validation.l` | `flex password_validation.l && gcc lex.yy.c -o password_validation && ./password_validation` |
