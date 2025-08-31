FROM python:3.10-slim

# Add non-free repositories and update
RUN echo "deb http://deb.debian.org/debian bullseye main non-free" > /etc/apt/sources.list && \
    echo "deb http://deb.debian.org/debian bullseye-updates main non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/debian-security bullseye-security main non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git \
        wget \
        curl \
        bash \
        ffmpeg \
        python3-pip \
        neofetch \
        software-properties-common && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

COPY . .
EXPOSE 5000

# Start both processes
CMD flask run -h 0.0.0.0 -p 5000 & python3 main.py
