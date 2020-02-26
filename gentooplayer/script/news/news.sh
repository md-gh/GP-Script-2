#!/bin/bash
rm -r /tmp/news 2>/dev/null

git clone https://github.com/antonellocaroli/GP-news.git /tmp/news 2>/dev/null

chmod +x /tmp/news/news.sh
clear
/tmp/news/news.sh
