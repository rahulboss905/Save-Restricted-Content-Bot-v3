FROM python:3.10-slim

# Update package lists and install all dependencies in a single layer
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git \
        wget \
        curl \
        bash \
        neofetch \
        ffmpeg \
        software-properties-common \
        python3-pip && \
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
