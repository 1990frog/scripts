#!/bin/bash

# 声音
get_volume() {
	volume="$(amixer get PCM | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	if test "$volume" -gt 0
	then
		echo -e "音量：${volume}%"
	else
		echo -e "Mute"
	fi
}

# CPU
get_cpu(){
	echo -e `top -b -n1 | grep ^%Cpu | awk '{printf("CPU：%.2f%"), 100-$8}'`
}

# 内存
get_memory(){
	echo -e `free --mebi | sed -n '2{p;q}' | awk '{printf ("内存：%2.2fGiB/%2.2fGiB(%.2f%)\n", ( $3 / 1024), ($2 / 1024), ($3/$2*100))}'`
}

# 日期
get_date(){
	echo -e "时间：$(date +'%Y年%m月%d日 %H:%M')"
}

while true; do
	xsetroot -name "$(get_cpu) , $(get_memory) , $(get_date) , $(get_volume)"
	sleep 1s
done
# xsetroot -name "$(get_cpu) , $(get_memory) , $(get_date) , $(get_volume)"
