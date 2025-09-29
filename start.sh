#!/bin/bash

echo "🚀 启动 OnlyOffice Document Server..."

# 检查Docker是否安装
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 未安装，请先安装 Docker"
    exit 1
fi

# 检查Docker Compose是否安装
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose 未安装，请先安装 Docker Compose"
    exit 1
fi

# 创建必要的目录
echo "📁 创建必要的目录..."
mkdir -p data logs fonts db

# 启动服务
echo "🔧 启动服务..."
docker-compose up -d

# 等待服务启动
echo "⏳ 等待服务启动..."
sleep 10

# 检查服务状态
echo "📊 检查服务状态..."
docker-compose ps

# 检查服务是否正常运行
if docker-compose ps | grep -q "Up"; then
    echo "✅ OnlyOffice 启动成功！"
    echo ""
    echo "🌐 访问地址："
    echo "   - Web界面: http://localhost:8080"
    echo "   - 客户端示例: http://localhost:8080/client-example.html"
    echo ""
    echo "📝 查看日志："
    echo "   docker-compose logs -f"
    echo ""
    echo "🛑 停止服务："
    echo "   docker-compose down"
else
    echo "❌ 服务启动失败，请检查日志："
    docker-compose logs
fi
