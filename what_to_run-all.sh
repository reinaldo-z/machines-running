#!/bin/bash

declare -a KPTS=(2452 3202 4052 5002 6052 7202 8452)

NV=20
NC=20
I_SPIN=10

for i in ${KPTS[@]}; do

	################## RUN TINIBA ##################
	run_tiniba.sh -r setkp -k "$i"
	printf "w started at $( date ) \n" >> .completed_all
	run_tiniba.sh -r run -k "$i" -N 0 -x 2 -e -p -s
	printf "finished at: $( date )\n #####\n" >> .completed_all
	
	################## RUN ALL RESPONSES ##################
	printf "Responses for $i -kpts started at $( date ) \n" >> .completed_all
	all_responses.sh -w total -m "$i"_"$I_SPIN" -s 0 -o 1 -v "$NV" -c "$NC" -r 1 -t "xx yy zz"
	all_responses.sh -w total -m "$i"_"$I_SPIN" -s 0 -o 1 -v "$NV" -c "$NC" -r 3 -t "xxy yxy zxy"
	all_responses.sh -w total -m "$i"_"$I_SPIN" -s 0 -o 1 -v "$NV" -c "$NC" -r 41 -t "xxy yxy zxy"
	printf "finished at $( date ) \n ##### \n " >> .completed_all


done