for i in `seq 0 $2` ;
do 
ping -c 1 $1.$i|grep "64 bytes"|cut -d " " -f 4 | tr -d  ":" &
done

