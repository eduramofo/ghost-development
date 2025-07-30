#!/bin/bash
set -e

# Detecta versão atual do Ghost
GHOST_VERSION=$(ls /var/lib/ghost/versions | sort -V | tail -n 1)

# Remove content da versão e cria symlink
rm -rf /var/lib/ghost/versions/$GHOST_VERSION/content
ln -s /var/lib/ghost/content /var/lib/ghost/versions/$GHOST_VERSION/content

echo "[init-fix] Symlink aplicado para versão $GHOST_VERSION"
