# Secreted proteins and effectors

signalp6 --fastafile Gigaspora_margarita_BEG.proteins.fa --organism eukarya --output_dir SignalP-EffectorP --format txt --mode fast

awk '{print $1}' SignalP-EffectorP/region_output.gff3 | grep -v '#' | sort | uniq > 02-SP-list.txt
awk 'FNR==NR{a[$0];next} /^>/{val=$0;sub(/^>/,"",val);flag=val in a?1:0} flag' 02-SP-list.txt Giga-prot-simple.fa > 03-SP-sequences.fa

python /home/eniac/jordana/EffectorP-3.0/EffectorP.py -i 03-SP-sequences.fa -o 04-Gigaspora-mar-effector-pred.txt

grep -v 'Non-effector' 04-Gigaspora-mar-effector-pred.txt | grep -v '#' | awk '{print $1}' > 05-Effector-list.txt

awk 'FNR==NR{a[$0];next} /^>/{val=$0;sub(/^>/,"",val);flag=val in a?1:0} flag' 05-Effector-list.txt Giga-prot-
simple.fa > 06-Giga-effectors-sequences.fa
