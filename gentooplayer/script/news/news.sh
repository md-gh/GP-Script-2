#!/bin/bash
rm -r /tmp/news 2>/dev/null

cd /tmp

rm -r GP-news-master 2>/dev/null
#git clone https://github.com/antonellocaroli/GP-news.git /tmp/news 2>/dev/null
wget https://github.com/antonellocaroli/GP-news/archive/master.zip 2>/dev/null

unzip master.zip

chmod +x /tmp/GP-news-master/news.sh




#chmod +x /tmp/news/news.sh
clear
/tmp/news/news.sh
exit 0
