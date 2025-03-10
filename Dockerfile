# Use Python 3.12 image
FROM python:3.12

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip and install uv
RUN pip install --upgrade pip
RUN pip install uv

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies using uv with --system flag
RUN uv pip install --system --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Add the application directory to PYTHONPATH
ENV PYTHONPATH=/app:$PYTHONPATH

# Expose port (adjust as needed)
EXPOSE 8000

# Command to run the FastAPI application with uvicorn's reload flag
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
