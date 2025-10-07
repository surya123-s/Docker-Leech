FROM downloaderzone/wzmlx:v3

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN uv venv --system-site-packages

COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt

COPY . .

# Start script
CMD ["bash", "start.sh"]
