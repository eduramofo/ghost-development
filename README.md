# Setup for Dev

## 1️⃣ Criar estrutura de conteúdo
mkdir -p content/data

## 2️⃣ Criar script de inicialização para corrigir o bug do /versions
chmod +x init-fix.sh

## 3️⃣ Criar docker-compose.yml
docker compose up -d

echo "✅ Ghost rodando em http://localhost:2368"
echo "✅ Admin em http://localhost:2368/ghost"
