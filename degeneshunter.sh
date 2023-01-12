#! /bin/bash
 
#Comparacion AcutevsResolution
degenes_Hunter.R -i featurecounts.txt -t target_file_1 -r 1 -l 7 -M TRUE -v "~Sex+treat" -m DEL -c 3 -f 0.585 -p 0.05
functional_Hunter.R -i hunter_DE_results -m Human -A o -P 0.1 -f gR


#Comparacion IntakevsBefore
degenes_Hunter.R -i featurecounts.txt -t target_file_2 -r 1 -l 7 -M TRUE -v "~Sex+treat" -m DEL -c 3 -f 0.585 -p 0.05
functional_Hunter.R -i hunter_DE_results -m Human -A o -P 0.1 -f gR


#Comparacion AcutevsIntake
degenes_Hunter.R -i featurecounts.txt -t target_file_3 -r 1 -l 7 -M TRUE -v "~Sex+treat" -m DEL -c 3 -f 0.585 -p 0.05
functional_Hunter.R -i hunter_DE_results -m Human -A o -P 0.1 -f gR