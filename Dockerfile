# Use a lightweight Python image
FROM python:3.9-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8080

# Set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first to leverage Docker cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Install the package (remove -e for production)
RUN pip install --no-cache-dir .

RUN python pipeline/training_pipeline.py

# Expose the correct port for Cloud Run
EXPOSE 8080

# Use Gunicorn as production server
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "application:app"]