DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PASS=0
FAIL=0

test_prog() {
    local name="$1"
    local dir="$2"
    local cmd="$3"
    echo -n "Testing [$name]... "
    if (cd "$DIR/$dir" && eval "$cmd") > /dev/null 2>&1; then
        echo "PASS"
        PASS=$((PASS + 1))
    else
        echo "FAIL"
        FAIL=$((FAIL + 1))
    fi
}

echo "=========================================="
echo "Compiling & Verifying all 30 Easy Programs"
echo "=========================================="

test_prog "Exp01" "Exp01_Lexical_Analyzer_C" "gcc lexical_analyzer.c -o lexical_analyzer && ./lexical_analyzer"
test_prog "Exp02" "Exp02_Lexical_Analyzer_Lex" "flex lexical_analyzer.l && gcc lex.yy.c -o lexical_analyzer && ./lexical_analyzer"
test_prog "Exp03" "Exp03_Words_Lines_Chars_Lex" "flex count.l && gcc lex.yy.c -o count && printf 'Hello World\n' | ./count"
test_prog "Exp04" "Exp04_Convert_Substring_abc" "flex replace_abc.l && gcc lex.yy.c -o replace_abc && printf 'abc 123\n' | ./replace_abc"
test_prog "Exp05" "Exp05_Vowels_Consonants_Lex" "flex vowels_consonants.l && gcc lex.yy.c -o vowels_consonants && printf 'Hello\n' | ./vowels_consonants"
test_prog "Exp06" "Exp06_Valid_Arithmetic_Expression_Yacc" "yacc -d expr.y && flex expr.l && gcc y.tab.c lex.yy.c -o expr && printf 'a+b\n' | ./expr"
test_prog "Exp07" "Exp07_Valid_Identifier_Yacc" "yacc -d identifier.y && flex identifier.l && gcc y.tab.c lex.yy.c -o identifier && printf 'var1\n' | ./identifier"
test_prog "Exp08" "Exp08_Calculator_Lex_Yacc" "yacc -d calc.y && flex calc.l && gcc y.tab.c lex.yy.c -o calc && printf '2+3*4\n' | ./calc"
test_prog "Exp09" "Exp09_Epsilon_Closure" "gcc epsilon_closure.c -o epsilon_closure && printf '2 1\n0 e 1\n' | ./epsilon_closure"
test_prog "Exp10" "Exp10_First" "gcc first.c -o first && printf '2\nS=aB\nB=b\n' | ./first"
test_prog "Exp11" "Exp11_Follow" "gcc follow.c -o follow && printf '2\nS=aB\nB=b\n' | ./follow"
test_prog "Exp12" "Exp12_Recursive_Descent_Parser" "gcc recursive_descent_parser.c -o recursive_descent_parser && printf 'i+i\n' | ./recursive_descent_parser"
test_prog "Exp13" "Exp13_Shift_Reduce_Parser" "gcc shift_reduce_parser.c -o shift_reduce_parser && printf 'i+i\n' | ./shift_reduce_parser"
test_prog "Exp14" "Exp14_Constant_Propagation" "gcc constant_propagation.c -o constant_propagation && printf '2\na = 5\nb = a + 2\n' | ./constant_propagation"
test_prog "Exp15" "Exp15_Intermediate_Code_Generation" "gcc intermediate_code_gen.c -o intermediate_code_gen && printf 'x = a + b\n' | ./intermediate_code_gen"
test_prog "Exp16" "Exp16_Target_Code_Generation" "gcc target_code_gen.c -o target_code_gen && printf '1\nt1 = a + b\n' | ./target_code_gen"

test_prog "Set1_01" "Extra_LEX_Programms/Set1_01_Simple_Compound_Sentence" "flex simple_compound.l && gcc lex.yy.c -o simple_compound && printf 'he and she\n' | ./simple_compound"
test_prog "Set1_02" "Extra_LEX_Programms/Set1_02_Reverse_Word" "flex reverse_word.l && gcc lex.yy.c -o reverse_word && printf 'hello\n' | ./reverse_word"
test_prog "Set1_03" "Extra_LEX_Programms/Set1_03_Largest_Three_Numbers" "flex largest_three.l && gcc lex.yy.c -o largest_three && printf '1 5 3\n' | ./largest_three"
test_prog "Set1_04" "Extra_LEX_Programms/Set1_04_Count_Words_Len_5_to_10" "flex count_words_5_to_10.l && gcc lex.yy.c -o count_words_5_to_10 && printf 'wonderful day\n' | ./count_words_5_to_10"
test_prog "Set1_05" "Extra_LEX_Programms/Set1_05_Char_Frequency" "flex char_frequency.l && gcc lex.yy.c -o char_frequency && printf 'a\nbanana\n' | ./char_frequency"
test_prog "Set1_06" "Extra_LEX_Programms/Set1_06_Longest_Word_Length" "flex longest_word.l && gcc lex.yy.c -o longest_word && printf 'hi universe\n' | ./longest_word"
test_prog "Set1_07" "Extra_LEX_Programms/Set1_07_String_Starting_Vowel" "flex starting_vowel.l && gcc lex.yy.c -o starting_vowel && printf 'apple\n' | ./starting_vowel"
test_prog "Set1_08" "Extra_LEX_Programms/Set1_08_Count_Pos_Neg_Int_Float" "flex count_pos_neg.l && gcc lex.yy.c -o count_pos_neg && printf '1 -2 3.5 -4.5\n' | ./count_pos_neg"

test_prog "Set2_01" "Extra_LEX_Programms/Set2_01_Palindrome_Word" "flex palindrome.l && gcc lex.yy.c -o palindrome && printf 'racecar\n' | ./palindrome"
test_prog "Set2_02" "Extra_LEX_Programms/Set2_02_Fibonacci_Series" "flex fibonacci.l && gcc lex.yy.c -o fibonacci && printf '10\n' | ./fibonacci"
test_prog "Set2_03" "Extra_LEX_Programms/Set2_03_Even_Odd_Factorial" "flex even_odd_factorial.l && gcc lex.yy.c -o even_odd_factorial && printf '4\n' | ./even_odd_factorial"
test_prog "Set2_04" "Extra_LEX_Programms/Set2_04_Armstrong_Number" "flex armstrong.l && gcc lex.yy.c -o armstrong && printf '153\n' | ./armstrong"
test_prog "Set2_05" "Extra_LEX_Programms/Set2_05_Sum_Of_Digits" "flex sum_of_digits.l && gcc lex.yy.c -o sum_of_digits && printf '1234\n' | ./sum_of_digits"
test_prog "Set2_06" "Extra_LEX_Programms/Set2_06_Password_Validation" "flex password_validation.l && gcc lex.yy.c -o password_validation && printf 'Pass1234\n' | ./password_validation"

echo "=========================================="
echo "Results: $PASS / 30 Passed ($FAIL Failed)"
echo "=========================================="
if [ $FAIL -ne 0 ]; then
    exit 1
fi
