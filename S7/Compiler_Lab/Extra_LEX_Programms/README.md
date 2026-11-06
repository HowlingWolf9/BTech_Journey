# Extra LEX Programs (Continuous Evaluation Lab Exercises)

This directory contains solutions for the additional LEX exercises (Set 1 and Set 2) based on the Seventh Semester B.Tech First Continuous Evaluation (CSL411 Compiler Lab).

Every experiment is self-contained in its own dedicated directory, written in clean, standard Lex (`.l`), begins with a step-by-step numbered algorithm in block comments, and concludes with verified sample execution outputs in comments.

---

## Index of Exercises

### SET 1
| # | Experiment Folder | Description | Executable |
|---|-------------------|-------------|------------|
| 1 | [`Set1_01_Simple_Compound_Sentence`](./Set1_01_Simple_Compound_Sentence) | Recognize simple or compound sentence (FANBOYS conjunctions) | `simple_compound` |
| 2 | [`Set1_02_Reverse_Word`](./Set1_02_Reverse_Word) | Reverse a given word | `reverse_word` |
| 3 | [`Set1_03_Largest_Three_Numbers`](./Set1_03_Largest_Three_Numbers) | Find largest among three numbers | `largest_three` |
| 4 | [`Set1_04_Count_Words_Len_5_to_10`](./Set1_04_Count_Words_Len_5_to_10) | Count words with length > 5 and < 10 | `count_words_5_to_10` |
| 5 | [`Set1_05_Char_Frequency`](./Set1_05_Char_Frequency) | Count frequency of a given character in a sentence | `char_frequency` |
| 6 | [`Set1_06_Longest_Word_Length`](./Set1_06_Longest_Word_Length) | Find length of the longest word in a given string | `longest_word` |
| 7 | [`Set1_07_String_Starting_Vowel`](./Set1_07_String_Starting_Vowel) | Accept a string starting with vowels | `starting_vowel` |
| 8 | [`Set1_08_Count_Pos_Neg_Int_Float`](./Set1_08_Count_Pos_Neg_Int_Float) | Count +ve/-ve integers and +ve/-ve floats | `count_pos_neg` |

### SET 2
| # | Experiment Folder | Description | Executable |
|---|-------------------|-------------|------------|
| 1 | [`Set2_01_Palindrome_Word`](./Set2_01_Palindrome_Word) | Check whether a word is palindrome | `palindrome` |
| 2 | [`Set2_02_Fibonacci_Series`](./Set2_02_Fibonacci_Series) | Print Fibonacci series up to a given limit | `fibonacci` |
| 3 | [`Set2_03_Even_Odd_Factorial`](./Set2_03_Even_Odd_Factorial) | Check even/odd and compute factorial | `even_odd_factorial` |
| 4 | [`Set2_04_Armstrong_Number`](./Set2_04_Armstrong_Number) | Check whether a number is Armstrong | `armstrong` |
| 5 | [`Set2_05_Sum_Of_Digits`](./Set2_05_Sum_Of_Digits) | Find the sum of digits of a given number | `sum_of_digits` |
| 6 | [`Set2_06_Password_Validation`](./Set2_06_Password_Validation) | Validate password length (>=8), upper, lower, digit | `password_validation` |

---

## Compilation & Run Instructions

All programs can be compiled using `flex` and `gcc`.

### Set 1

1. **Simple or Compound Sentence**:
   ```bash
   cd Set1_01_Simple_Compound_Sentence
   flex simple_compound.l
   gcc lex.yy.c -o simple_compound
   ./simple_compound
   ```

2. **Reverse Word**:
   ```bash
   cd Set1_02_Reverse_Word
   flex reverse_word.l
   gcc lex.yy.c -o reverse_word
   ./reverse_word
   ```

3. **Largest Among Three Numbers**:
   ```bash
   cd Set1_03_Largest_Three_Numbers
   flex largest_three.l
   gcc lex.yy.c -o largest_three
   ./largest_three
   ```

4. **Count Words (5 < length < 10)**:
   ```bash
   cd Set1_04_Count_Words_Len_5_to_10
   flex count_words_5_to_10.l
   gcc lex.yy.c -o count_words_5_to_10
   ./count_words_5_to_10
   ```

5. **Character Frequency**:
   ```bash
   cd Set1_05_Char_Frequency
   flex char_frequency.l
   gcc lex.yy.c -o char_frequency
   ./char_frequency
   ```

6. **Longest Word and Length**:
   ```bash
   cd Set1_06_Longest_Word_Length
   flex longest_word.l
   gcc lex.yy.c -o longest_word
   ./longest_word
   ```

7. **Accept String Starting with Vowel**:
   ```bash
   cd Set1_07_String_Starting_Vowel
   flex starting_vowel.l
   gcc lex.yy.c -o starting_vowel
   ./starting_vowel
   ```

8. **Count Positive/Negative Integers & Floats**:
   ```bash
   cd Set1_08_Count_Pos_Neg_Int_Float
   flex count_pos_neg.l
   gcc lex.yy.c -o count_pos_neg
   ./count_pos_neg
   ```

### Set 2

1. **Palindrome Word**:
   ```bash
   cd Set2_01_Palindrome_Word
   flex palindrome.l
   gcc lex.yy.c -o palindrome
   ./palindrome
   ```

2. **Fibonacci Series Up to Limit**:
   ```bash
   cd Set2_02_Fibonacci_Series
   flex fibonacci.l
   gcc lex.yy.c -o fibonacci
   ./fibonacci
   ```

3. **Even/Odd & Factorial**:
   ```bash
   cd Set2_03_Even_Odd_Factorial
   flex even_odd_factorial.l
   gcc lex.yy.c -o even_odd_factorial
   ./even_odd_factorial
   ```

4. **Armstrong Number**:
   ```bash
   cd Set2_04_Armstrong_Number
   flex armstrong.l
   gcc lex.yy.c -o armstrong
   ./armstrong
   ```

5. **Sum of Digits**:
   ```bash
   cd Set2_05_Sum_Of_Digits
   flex sum_of_digits.l
   gcc lex.yy.c -o sum_of_digits
   ./sum_of_digits
   ```

6. **Password Validation**:
   ```bash
   cd Set2_06_Password_Validation
   flex password_validation.l
   gcc lex.yy.c -o password_validation
   ./password_validation
   ```

---

## Batch Verification Script
To compile and execute test suites across all 14 programs at once:
```bash
bash build_and_test.sh
```
