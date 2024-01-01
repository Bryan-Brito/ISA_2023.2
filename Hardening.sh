#!/bin/bash

# Função para log
log() {
  echo "$(date +"%Y-%m-%d %H:%M:%S") $1" >> scanner.log
}

# a) Atualização do sistema
log "Iniciando a atualização do sistema"
sudo apt update && sudo apt upgrade -y
if [ $? -eq 0 ]; then
  log "Atualização do sistema bem-sucedida"
else
  log "Falha na atualização do sistema"
fi

# b) Habilitar NTP
log "Configurando Network Time Protocol (NTP)"
sudo apt install -y ntp
sudo timedatectl set-ntp true
sudo systemctl restart ntp
sudo systemctl enable ntp

# c) Reboot automático após Kernel Panic
log "Configurando reboot automático após Kernel Panic"
echo "kernel.panic = 30" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# d) Remover programas indesejados
log "Removendo programas indesejados"
while IFS= read -r program; do
  sudo apt remove --purge -y "$program"
done < programas.txt
log "Lista de programas removidos: $(cat programas.txt)"

# e) Desabilitar shell de usuários
log "Desabilitando shell de usuários"
while IFS= read -r username; do
  sudo usermod --shell /usr/sbin/nologin "$username"
done < usuarios.txt
log "Usuários com shell desativado: $(cat usuarios.txt)"

# f) Exibir informações adicionais no log
log "Informações adicionais:"
log "Distribuição Linux: $(lsb_release -d | cut -f2-)"
log "Versão do Kernel: $(uname -r)"
log "Data e hora de início: $(date +"%Y-%m-%d %H:%M:%S")"
log "Data e hora de fim: $(date +"%Y-%m-%d %H:%M:%S")"

# g) Exibir informações na tela
cat scanner.log

# Lembre-se de dar permissão de execução ao script:
# chmod +x hardening.sh
