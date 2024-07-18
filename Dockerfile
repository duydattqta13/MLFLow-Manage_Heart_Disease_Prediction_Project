# Sử dụng một image base Python
FROM python:3.9-slim

# Cài đặt các gói cần thiết
RUN apt-get update && apt-get install -y \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Tạo một thư mục làm việc
WORKDIR /app

# Cài đặt MLflow và các phụ thuộc
RUN pip install mlflow boto3

# Sao chép tất cả các tệp vào thư mục làm việc
COPY . .

# Đặt biến môi trường để chỉ định URI tracking
# ENV MLFLOW_TRACKING_URI=http://127.0.0.1:5000

# Mở cổng 5000
# EXPOSE 5000

# Lệnh để chạy MLflow

CMD ["mlflow", "ui"]
CMD ["python", "heart_prediction.py"]
# CMD ["mlflow", "server", "--host", "0.0.0.0", "--port", "5000", "--backend-store-uri", "sqlite:///mlflow.db", "--default-artifact-root", "./mlruns"]