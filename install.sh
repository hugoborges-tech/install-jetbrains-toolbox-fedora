#!/bin/bash

set -euo pipefail

# Instalar dependências
sudo dnf install -y jq fuse fuse-libs

# Obter o link de download do JetBrains Toolbox
toolbox_url=$(curl -s 'https://data.services.jetbrains.com/products/releases?code=TBA&latest=true&type=release' \
    | jq -r '.TBA[0].downloads.linux.link')

# Diretório de destino
destination="${HOME}/.local/share/JetBrains/Toolbox/bin"

# Criar o diretório de destino se ele não existir
mkdir -p "$destination"

# Baixar e extrair o JetBrains Toolbox
curl -sL "$toolbox_url" | tar xzvf - \
    --directory="$destination" \
    --wildcards */jetbrains-toolbox \
    --strip-components=1

# Executar o JetBrains Toolbox
"$destination/jetbrains-toolbox" &

echo "JetBrains Toolbox instalado e iniciado com sucesso em $destination"

