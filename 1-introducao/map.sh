#!/usr/bin/env bash
declare -A responses

for (( i = 0; i < 10; i++ )); do

  responses+=( [20$i]=$i )
  responses+=( [200]=$((count++)) )

done

for sound in "${!responses[@]}";
do
  echo "$sound - ${responses[$sound]}";
done
