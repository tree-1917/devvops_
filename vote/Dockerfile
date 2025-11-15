# ======================== #
# === Vote Docker File === #
# ======================== #

# Stage 1 — Builder
FROM python:3.9 As builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Stage 2 — Slim Production Image
FROM python:3.9-slim

WORKDIR /app

# Copy python packages only
COPY --from=builder /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# Copy your application
COPY --from=builder /app /app

EXPOSE 8000

# GuniCorn Process 
CMD ["gunicorn", "app:app", "-c", "gunicorn.config.py" ] 
