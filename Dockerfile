FROM downloaderzone/wzmlx:v3

# Set working directory
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install ffmpeg and added symlinks
RUN apt-get update && apt-get install -y ffmpeg && rm -rf /var/lib/apt/lists/* \
 && mkdir -p /JDownloader/tools/linux/ffmpeg/x64 \
 && ln -sf /usr/bin/ffmpeg /JDownloader/tools/linux/ffmpeg/x64/ffmpeg \
 && ln -sf /usr/bin/ffprobe /JDownloader/tools/linux/ffmpeg/x64/ffprobe

# Create virtual environment (with system site packages)
RUN uv venv --system-site-packages

# Install dependencies
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

# Copy project files
COPY . .

# Environment variables (can be overridden at runtime)
ENV BOT_TOKEN=""
ENV OWNER_ID=""
ENV TELEGRAM_API=""
ENV LEECH_DUMP_CHAT=""
ENV TELEGRAM_HASH=""
ENV DATABASE_URL=""

# Expose ports # The 3129 Port is for JDownload-Manager-WebUI 
EXPOSE 80 8080 3129

# Start script
CMD ["bash", "start.sh"]
