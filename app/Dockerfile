FROM python:3.12-slim

RUN apt-get update -y && apt-get install -y --no-install-recommends     curl ca-certificates && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PYTHONDONTWRITEBYTECODE=1     PYTHONUNBUFFERED=1

EXPOSE 5000
CMD ["python", "app.py"]