FROM downloaderzone/wzmlx:v3

# Set working directory
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install ffmpeg
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/*

# Create virtual environment (with system site packages)
RUN uv venv --system-site-packages

# Install dependencies
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Create symlinks for JDownloader to detect FFmpeg
RUN mkdir -p /JDownloader/tools/linux/ffmpeg/x64 && \
    ln -sf /usr/bin/ffmpeg /JDownloader/tools/linux/ffmpeg/x64/ffmpeg && \
    ln -sf /usr/bin/ffprobe /JDownloader/tools/linux/ffmpeg/x64/ffprobe

# Environment variables (can be overridden at runtime)
ENV BOT_TOKEN=""
ENV OWNER_ID=""
ENV TELEGRAM_API=""
ENV LEECH_DUMP_CHAT=""
ENV TELEGRAM_HASH=""
ENV DATABASE_URL=""

# Expose ports #3129 for jd
EXPOSE 80 8080 8090

# Start script
CMD ["bash", "start.sh"]
