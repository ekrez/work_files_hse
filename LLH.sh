#!/bin/bash

# split times T, например,  "20 27" 
# mgration rate mr, например, "0 0.5 1.0"

for t in T; 
do
mkdir Pumas.${t}
for j in mr1;
do

for i in mr2;
do
FILE=./Pumas.${t}/res.${i}.${j}.mi

./MiSTI.py genome1.psmc genome2.psmc mi.jaf ${t} --funits setunits.txt -uf --cpfit -o $FILE -pu 2 0 0.3 0 -mi 1 4 ${t} $i 0 -mi 2 4 ${t} $j 0


if test -f "$FILE"; then
    sed -n '2p' $FILE >> ./Pumas.${t}/output.$j.${t}.txt
else
    echo -e LK'\t'-9999999 >> ./Pumas.${t}/output.${j}.${t}.txt
fi
rm $FILE
done
cut -f 2 ./Pumas.${t}/output.${j}.${t}.txt >> ./Pumas.${t}/output2.$j.${t}.txt
done
done



for t in T;
do
cd ./Pumas.${t}
STR=""
for j in mr1;
do
    STR=$STR"output."$j".${t}.txt "
done
paste $STR  > pumas.result.${t}.txt
cd ../
done
