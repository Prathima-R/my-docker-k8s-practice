FROM python:3.10-slim AS builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /app

RUN pip install --user --no-cache-dir -r requirements.txt

FROM python:3.10-slim
      
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
    
WORKDIR /app
COPY --from=builder /root/.local /root/.local
    
ENV PATH=/root/.local/bin:$PATH 
    
COPY . /app
EXPOSE 8000
CMD ["python3","manage.py", "runserver","0.0.0.0:8000"]



