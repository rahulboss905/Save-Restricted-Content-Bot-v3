 FROM python:3.10.4-slim-buster

# Disable validation for expired repo metadata and switch to archived URLs
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until

RUN apt update && apt upgrade -y
RUN apt-get install -y git curl python3-pip ffmpeg wget bash neofetch software-properties-common

WORKDIR /app
COPY requirements.txt .

RUN pip3 install wheel
RUN pip3 install --no-cache-dir -U -r requirements.txt
COPY . .
EXPOSE 5000

CMD flask run -h 0.0.0.0 -p 5000 & python3 main.py
