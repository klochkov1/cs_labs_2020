#/usr/bin/sh                                                                                                                                                                                  
                                                                                                                                                                                              
src="bubble_sort.c"                                                                                                                                                                           
exe="${src%.*}_$RANDOM"                                                                                                                                                                       
randf="csv_$RANDOM"                                                                                                                                                                           
                                                                                                                                                                                              
for i in {0..3};                                                                                                                                                                              
do                                                                                                                                                                                            
        compile_cmd="gcc -std=c99 -O$i -o $exe $src"                                                                                                                                          
        echo "Compile:   $compile_cmd"                                                                                                                                                        
        $compile_cmd                                                                                                                                                                          
        time=$(/usr/bin/time -f "%E\n" 2>&1 ./$exe)                                                                                                                                           
        printf "Exec time: $time\n\n"                                                                                                                                                         
        printf "${time##*0:}, " >> $randf                                                                                                                                                     
done                                                                                                                                                                                          
printf "\n" >> $randf    
                                                                                                                                                                                        
ml icc                                                                                                                                                                                        
                                                                                                                                                                                              
for flag in $(cat /proc/cpuinfo | grep flags | tail -1 | cut -d ":" -f2);                                                                                                                     
do                                                                                                                                                                                            
        compile_cmd="icc -x$flag -std=c99 -O2 -o $exe $src"                                                                                                                                   
        $compile_cmd 2>/dev/null || continue                                                                                                                                                  
        echo "Compile:   $compile_cmd"                                                                                                                                                        
        time=$(/usr/bin/time -f "%E\n" 2>&1 ./$exe)                                                                                                                                           
        printf "Exec time: $time\n\n"                                                                                                                                                         
        printf "${time##*0:}, " >> $randf                                                                                                                                                     
done                                                                                                                                                                                          
printf "\n" >> $randf                                                                                                                                                                         