FROM python:3.12-slim-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libpq-dev default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
COPY subway/ ./subway/
COPY stories/ ./stories/
COPY library/ ./library/
COPY pages/ ./pages/
COPY accounts/ ./accounts/
COPY . .

RUN pip install --no-cache-dir --default-timeout=1000 -r requirements.txt

ENV PYTHONPATH="/app"
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "project.wsgi:application"]
