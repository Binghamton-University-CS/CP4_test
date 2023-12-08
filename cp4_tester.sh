#!/usr/bin/env bash

# HOW TO RUN:
# 
# 1. Copy the bash file (cp3_tester.h) and the expect file (cp3_subroutine.exp) to the same directory as your executable (e.g., bin directory).
# 2. cd to the directory of your executable (e.g., bin directory).
# 3. Execute the following command: 
#    "bash cp3_tester.sh ./<executable> <testcase-number>"
# 4. Refer to the 'EXPECTED OUTPUT DESCRIPTION' output and verify if your output contains the expected result.

if [ $# -ne 2 ]; then
	echo "bash cp4_tester.sh ./<executable> <testcase-number>"
	exit 1
fi

declare -A tests

# test-case 1 : praise_actor & award_actor
tests[1]="
register_actor 3 Johnson Dwayne
register_actor 4 Cooper Bradley
register_actor 2 Mitchell Shay
register_actor 5 Adams Amy
register_actor 1 Evans Chris
praise_actor Adams 300
praise_actor Evans 500
praise_actor Mitchell 100
award_actor
award_actor
award_actor
quit
"

# test-case 2 : show_praise 
tests[2]="
register_actor 3 Johnson Dwayne
register_actor 4 Cooper Bradley
register_actor 2 Mitchell Shay
register_actor 5 Adams Amy
register_actor 1 Evans Chris
praise_actor Adams 300
praise_actor Evans 500
praise_actor Mitchell 100
show_praise
quit
"

# test-case 3 : award_actor without praising
tests[3]="
register_actor 3 Johnson Dwayne
register_actor 4 Cooper Bradley
register_actor 2 Mitchell Shay
register_actor 5 Adams Amy
register_actor 1 Evans Chris
award_actor
quit
"

# test-case 4 : praise an awarded actor
tests[4]=" 
register_actor 3 Johnson Dwayne
register_actor 4 Cooper Bradley
register_actor 2 Mitchell Shay
register_actor 5 Adams Amy
register_actor 1 Evans Chris
praise_actor Evans 500
award_actor
praise_actor Evans 500
quit
"

# test-case 5 : remove_actor (optional)
tests[5]=" 
register_actor 3 Johnson Dwayne
register_actor 4 Cooper Bradley
register_actor 2 Mitchell Shay
register_actor 5 Adams Amy
register_actor 1 Evans Chris
praise_actor Johnson 20
remove_actor 3
show_praise
praise_actor Johnson 10
award_actor
quit
"

# DESIRED RESULTS
declare -A desired_result

desired_result[1]="
(expected last 3 outputs):
Actor Chris Evans presented with a Lifetime Achievement Award (500 praise points)
Actor Amy Adams presented with a Lifetime Achievement Award (300 praise points)
Actor Shay Mitchell presented with a Lifetime Achievement Award (100 praise points)
"

desired_result[2]="
(expected last 5 outputs)
1 Chris Evans has 500 praise points
2 Shay Mitchell has 100 praise points
3 Dwayne Johnson has 0 praise points
4 Bradley Cooper has 0 praise points
5 Amy Adams has 300 praise points
"

desired_result[3]="
(expected last output -- likely 'Dwayne Johnson' as first added (likely root of the heap-array being appended first), but printing another actor is also acceptable)
Actor Dwayne Johnson presented with a Lifetime Achievement Award (0 praise points)
"

desired_result[4]="
(expected last 2 outputs)
Actor Chris Evans presented with a Lifetime Achievement Award (500 praise points)
That's nice but actor Chris Evans has already received the award.
"

desired_result[5]="
(expected last 6 outputs)
1 Chris Evans has 0 praise points
2 Shay Mitchell has 0 praise points
4 Bradley Cooper has 0 praise points
5 Amy Adams has 0 praise points
< Should not be able praise Johnson (output message optional) >
< Award anyone with 0 points, other than Johnson >
"

# INTERACTION
clear 
#interaction=$(expect cp3_subroutine.exp "$1" "$2" "${tests[$3]}" 2>&1)
#key_results=$(echo "$interaction" | tail -n20)
#echo "$interaction"

expect cp4_subroutine.exp "$1" "${tests[$2]}" 2>&1
printf "\n\n********** EXPECTED OUTPUT DESCRIPTION **********\\n\n${desired_result[$2]}\n\n\n"


exit 0


