#!/usr/bin/env bash
set -e

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "=== Building and Testing All Extra LEX Programs ==="
echo "Base Directory: $BASE_DIR"
echo ""

FAILURES=0

run_test() {
    local dir="$1"
    local l_file="$2"
    local bin="$3"
    local input="$4"
    local desc="$5"

    echo "------------------------------------------------------------"
    echo "[$dir] $desc"
    cd "$BASE_DIR/$dir"

    # Build
    flex "$l_file"
    gcc lex.yy.c -o "$bin"
    rm -f lex.yy.c

    # Test
    echo "Running: printf '%s\n' \"$input\" | ./$bin"
    output=$(printf "%b\n" "$input" | ./"$bin")
    echo "$output"
    echo "Status: SUCCESS"
}

# SET 1
run_test "Set1_01_Simple_Compound_Sentence" "simple_compound.l" "simple_compound" "I like apples but I prefer oranges." "Set 1 - 01: Compound Sentence"
run_test "Set1_01_Simple_Compound_Sentence" "simple_compound.l" "simple_compound" "The cat slept on the mat." "Set 1 - 01: Simple Sentence"
run_test "Set1_01_Simple_Compound_Sentence" "simple_compound.l" "simple_compound" "" "Set 1 - 01: Empty Sentence"

run_test "Set1_02_Reverse_Word" "reverse_word.l" "reverse_word" "Compiler" "Set 1 - 02: Reverse Word"
run_test "Set1_02_Reverse_Word" "reverse_word.l" "reverse_word" "" "Set 1 - 02: Empty Word"

run_test "Set1_03_Largest_Three_Numbers" "largest_three.l" "largest_three" "45 120 78" "Set 1 - 03: Largest of Three Numbers"
run_test "Set1_03_Largest_Three_Numbers" "largest_three.l" "largest_three" "-15.5 0 9.25" "Set 1 - 03: Largest with Negative/Float"

run_test "Set1_04_Count_Words_Len_5_to_10" "count_words_5_to_10.l" "count_words_5_to_10" "Compiler design laboratory teaches students parsing techniques" "Set 1 - 04: Words Length Between 5 and 10"

run_test "Set1_05_Char_Frequency" "char_frequency.l" "char_frequency" "e\nhello everyone everywhere" "Set 1 - 05: Character Frequency"

run_test "Set1_06_Longest_Word_Length" "longest_word.l" "longest_word" "Natural language processing and compiler optimization" "Set 1 - 06: Longest Word Length"

run_test "Set1_07_String_Starting_Vowel" "starting_vowel.l" "starting_vowel" "Apple" "Set 1 - 07: Starts with Vowel (Accepted)"
run_test "Set1_07_String_Starting_Vowel" "starting_vowel.l" "starting_vowel" "banana" "Set 1 - 07: Starts with Consonant (Rejected)"
run_test "Set1_07_String_Starting_Vowel" "starting_vowel.l" "starting_vowel" "" "Set 1 - 07: Empty String (Rejected)"

run_test "Set1_08_Count_Pos_Neg_Int_Float" "count_pos_neg.l" "count_pos_neg" "25 -10 +45 -3 3.14 -0.05 +99.99 -8.5" "Set 1 - 08: Count Pos/Neg Int and Float"

# SET 2
run_test "Set2_01_Palindrome_Word" "palindrome.l" "palindrome" "Madam" "Set 2 - 01: Palindrome (True)"
run_test "Set2_01_Palindrome_Word" "palindrome.l" "palindrome" "Computer" "Set 2 - 01: Palindrome (False)"
run_test "Set2_01_Palindrome_Word" "palindrome.l" "palindrome" "" "Set 2 - 01: Empty Word"

run_test "Set2_02_Fibonacci_Series" "fibonacci.l" "fibonacci" "50" "Set 2 - 02: Fibonacci Series"
run_test "Set2_02_Fibonacci_Series" "fibonacci.l" "fibonacci" "-10" "Set 2 - 02: Negative Limit (Error Handled)"

run_test "Set2_03_Even_Odd_Factorial" "even_odd_factorial.l" "even_odd_factorial" "5" "Set 2 - 03: Even/Odd & Factorial (5)"
run_test "Set2_03_Even_Odd_Factorial" "even_odd_factorial.l" "even_odd_factorial" "8" "Set 2 - 03: Even/Odd & Factorial (8)"
run_test "Set2_03_Even_Odd_Factorial" "even_odd_factorial.l" "even_odd_factorial" "-5" "Set 2 - 03: Negative Number (-5 Undefined)"

run_test "Set2_04_Armstrong_Number" "armstrong.l" "armstrong" "153" "Set 2 - 04: Armstrong (153)"
run_test "Set2_04_Armstrong_Number" "armstrong.l" "armstrong" "125" "Set 2 - 04: Not Armstrong (125)"
run_test "Set2_04_Armstrong_Number" "armstrong.l" "armstrong" "-153" "Set 2 - 04: Negative Number (Rejected)"

run_test "Set2_05_Sum_Of_Digits" "sum_of_digits.l" "sum_of_digits" "12345" "Set 2 - 05: Sum of Digits"
run_test "Set2_05_Sum_Of_Digits" "sum_of_digits.l" "sum_of_digits" "-9876" "Set 2 - 05: Sum of Digits Signed (-9876)"

run_test "Set2_06_Password_Validation" "password_validation.l" "password_validation" "Pass1234" "Set 2 - 06: Password Validation (Valid)"
run_test "Set2_06_Password_Validation" "password_validation.l" "password_validation" "pass" "Set 2 - 06: Password Validation (Invalid)"
run_test "Set2_06_Password_Validation" "password_validation.l" "password_validation" "" "Set 2 - 06: Password Validation (Empty)"

echo "------------------------------------------------------------"
echo "All 14 Extra LEX programs compiled and tested successfully!"
