FROM python:3.9-slim

# 작업 디렉토리 설정
WORKDIR /app

# 시스템 dependencies 설치
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    cron \
    && rm -rf /var/lib/apt/lists/*

# Playwright 브라우저 의존성 설치
RUN playwright install chromium
RUN playwright install-deps

# 필요한 Python 패키지 설치
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 볼륨 마운트를 위한 디렉토리 생성
RUN mkdir -p /app/output

# 애플리케이션 파일 복사
COPY scraper.py .
COPY .env .

# crontab 설정 파일 생성
RUN echo "0 * * * * python /app/scraper.py \$(cat /app/.env | grep URL | cut -d '=' -f2) /app/output/rss.xml" > /etc/cron.d/scraper-cron
RUN chmod 0644 /etc/cron.d/scraper-cron
RUN crontab /etc/cron.d/scraper-cron

# cron 및 스크립트 실행을 위한 시작 스크립트
COPY start.sh .
RUN chmod +x start.sh

CMD ["./start.sh"]
