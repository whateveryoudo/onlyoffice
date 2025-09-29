# OnlyOffice Docker 配置

这是一个用于部署OnlyOffice Document Server的Docker配置。

## 前置要求

- Docker
- Docker Compose

## 快速开始

### 1. 启动服务

```bash
# 启动所有服务
docker-compose up -d

# 查看服务状态
docker-compose ps

# 查看日志
docker-compose logs -f
```

### 2. 访问OnlyOffice

启动成功后，您可以通过以下地址访问OnlyOffice：

- **Web界面**: http://localhost:8080
- **API接口**: http://localhost:8080/web-apps/apps/api/documents/api.js

### 3. 停止服务

```bash
# 停止所有服务
docker-compose down

# 停止并删除数据卷（谨慎使用）
docker-compose down -v
```

## 配置说明

### 环境变量

- `JWT_ENABLED`: 启用JWT认证
- `JWT_SECRET`: JWT密钥（请修改为您的密钥）
- `WOPI_ENABLED`: 启用WOPI协议支持
- `DB_TYPE`: 数据库类型（postgres）
- `DB_HOST`: 数据库主机
- `DB_PORT`: 数据库端口
- `DB_NAME`: 数据库名称
- `DB_USER`: 数据库用户名
- `DB_PWD`: 数据库密码

### 端口映射

- `8080:80`: 将容器的80端口映射到主机的8080端口

### 数据卷

- `./data`: OnlyOffice数据存储
- `./logs`: 日志文件
- `./fonts`: 自定义字体
- `./db`: PostgreSQL数据库数据

## 客户端集成

### 1. 创建文档编辑器

```html
<!DOCTYPE html>
<html>
<head>
    <script src="http://localhost:8080/web-apps/apps/api/documents/api.js"></script>
</head>
<body>
    <div id="placeholder"></div>
    <script>
        new DocsAPI.DocEditor("placeholder", {
            document: {
                fileType: "docx",
                key: "unique-document-key",
                title: "示例文档.docx",
                url: "http://your-server.com/path/to/document.docx"
            },
            documentType: "word",
            editorConfig: {
                callbackUrl: "http://your-server.com/callback",
                user: {
                    id: "user-id",
                    name: "用户名"
                }
            },
            height: "100%",
            width: "100%"
        });
    </script>
</body>
</html>
```

### 2. 使用API

```javascript
// 创建文档
fetch('http://localhost:8080/web-apps/apps/api/documents/api.js', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer your-jwt-token'
    },
    body: JSON.stringify({
        document: {
            fileType: "docx",
            key: "unique-key",
            title: "新文档.docx",
            url: "http://your-server.com/document.docx"
        },
        documentType: "word",
        editorConfig: {
            callbackUrl: "http://your-server.com/callback",
            user: {
                id: "user-id",
                name: "用户名"
            }
        }
    })
});
```

## 故障排除

### 1. 检查容器状态

```bash
docker-compose ps
docker-compose logs onlyoffice-ds
docker-compose logs onlyoffice-db
```

### 2. 重启服务

```bash
docker-compose restart
```

### 3. 清理并重新开始

```bash
docker-compose down -v
docker-compose up -d
```

## 安全注意事项

1. 修改默认的JWT密钥
2. 在生产环境中使用HTTPS
3. 配置防火墙规则
4. 定期备份数据

## 更多信息

- [OnlyOffice官方文档](https://helpcenter.onlyoffice.com/)
- [Docker Hub - OnlyOffice](https://hub.docker.com/r/onlyoffice/documentserver)
