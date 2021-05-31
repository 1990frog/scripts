#!/bin/bash

# 声音
get_volume() {
	volume="$(amixer get PCM | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')"
	echo -e "${volume}%"
}

# CPU
get_cpu(){
	echo -e `top -b -n1 | grep ^%Cpu | awk '{printf("%.2f%"), 100-$8}'`
}

# 内存
get_memory(){
	echo -e `free --mebi | sed -n '2{p;q}' | awk '{printf ("%2.2fGiB/%2.2fGiB(%.2f%)\n", ( $3 / 1024), ($2 / 1024), ($3/$2*100))}'`
}

# 日期
get_date(){
	echo -e "$(date +'%Y年%m月%d日 %H:%M')"
}

# 轮询刷新
while true; do
	xsetroot -name "cpu:$(get_cpu)，mem:$(get_memory)，time:$(get_date)，volume:$(get_volume)"
	sleep 1s
done
