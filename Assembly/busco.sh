 docker run -u $(id -u) -v $(pwd):/busco_wd ezlabgva/busco:v5.7.0_cv1 busco -i Gigaspora_margarita_BEG.proteins.fa -o Gigaspora-busco -l fungi_odb10 -m prot -c 30 -f
