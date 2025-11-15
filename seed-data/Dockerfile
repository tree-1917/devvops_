# ============================ #
# === Seed Data Dockerfile === #
# ============================ #

FROM python:3.9

# Install required utilities
RUN apt update && apt install -y curl apache2-utils

# Set working directory
WORKDIR /utils

# Copy your scripts
COPY . .

CMD ["sh"]

