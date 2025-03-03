#!/bin/bash
cron
# 초기 실행
python /app/scraper.py $(cat /app/.env | grep URL | cut -d '=' -f2) /app/output/output.rss
# 로그 확인을 위해 크론 로그를 표시
tail -f /var/log/cron.log
