# syntax=docker/dockerfile:1
FROM python:3.9-slim

# 设置工作目录
WORKDIR /workspace

# 安装系统依赖
RUN --mount=type=cache,target=/var/cache/apt \
    apt-get update && apt-get install -y \
    gcc \
    libffi-dev \
    python3-dev

# 首先只复制依赖文件
COPY requirements.txt .

# 使用缓存挂载安装 Python 依赖
RUN --mount=type=cache,target=/root/.cache/pip \
    pip install --no-cache-dir -r requirements.txt

# 复制其余项目文件
COPY . .

ENV PYTHONPATH=/workspace

CMD ["python", "app.py"]
