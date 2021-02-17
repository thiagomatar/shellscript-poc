#!/usr/bin/env bash

# Existem algumas formas de se usar o loops, abaixo alguns exemplos:
echo "-> for";
for (( i = 0; i < 10; i++ )); do
  echo $i
done

echo "-> seq"
for i in $(seq 10); do
  echo $i
done

# Loop sob um array
echo "-> array"
Array=(
  'elemento_1'
  'elemento_2'
  'elemento_3'
)

for i in "${Array[@]}"; do
 echo "$i"
done

echo "-> while"
count=0
while [[ $count -lt ${#Array[@]} ]]; do
  echo $count;
  count=$(($count + 1))
done
