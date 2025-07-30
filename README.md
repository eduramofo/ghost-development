#!/bin/bash
# 🚀 Setup rápido do Ghost CMS em modo DEV (SQLite + fix do /versions)

# 1️⃣ Criar estrutura de conteúdo
mkdir -p content/data

# 2️⃣ Criar script de inicialização para corrigir o bug do /versions
cat > init-fix.sh <<'EOF'
#!/bin/bash
set -e
GHOST_VERSION=$(ls /var/lib/ghost/versions | sort -V | tail -n 1)
rm -rf /var/lib/ghost/versions/$GHOST_VERSION/content
ln -s /var/lib/ghost/content /var/lib/ghost/versions/$GHOST_VERSION/content
echo "[init-fix] Symlink aplicado para versão $GHOST_VERSION"
EOF
chmod +x init-fix.sh

# 3️⃣ Criar docker-compose.yml
cat > docker-compose.yml <<'EOF'
version: "3.8"
services:
  ghost:
    image: ghost:latest
    container_name: ghost_cms
    restart: unless-stopped
    ports:
      - "2368:2368"
    environment:
      NODE_ENV: development
      url: http://localhost:2368
    volumes:
      - ./content:/var/lib/ghost/content
      - ./init-fix.sh:/docker-entrypoint-init.d/init-fix.sh:ro
EOF

# 4️⃣ Subir o Ghost em modo DEV
docker compose up -d

echo "✅ Ghost rodando em http://localhost:2368"
echo "✅ Admin em http://localhost:2368/ghost"
