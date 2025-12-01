# SNEP – HomeLab|CampusLab|BusinessLab Proxmox (by JohanSE17)
Configuraciones y scripts para homelab, campuslab y businesslabs basado en Proxmox/guac: instalación, LXC/VMs, automatización con Ansible. Reproducible y modular.

![Proxmox](https://img.shields.io/badge/Proxmox-8.2+-E57000?logo=proxmox&logoColor=white)
![LXC](https://img.shields.io/badge/LXC-Containers-00D0D0)
![Docker](https://img.shields.io/badge/Docker-20+-2496ED?logo=docker)
![Tailscale](https://img.shields.io/badge/Tailscale-Remote_Access-00C2FF)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

**S**elf-hosted **N**etwork **E**nterprise **P**latform – Mi homelab 100 % reproducible basado en Proxmox VE (kernel 6.8.12-16-pve) con más de 15 contenedores LXC + Docker, acceso remoto seguro y laboratorio de pentesting.

Todo el setup se puede levantar desde cero en otro nodo Proxmox con un solo `git clone` + `ansible-playbook` (próximamente).

## Servicios actuales (2025-12-01)

| Tipo | ID   | Nombre           | Uso principal                                  | Puerto externo |
|------|------|------------------|------------------------------------------------|----------------|
| VM   | 107  | Wins             | Windows 11 + herramientas dev                  | RDP 3389       |
| LXC  | 110  | Ubun24           | Base Ubuntu 24.04                              | –              |
| LXC  | 111  | sn8nep           | n8n SNEP                                       | –              |
| LXC  | 113  | postg8n          | PostgreSQL 13 (Guacamole + apps)               | –              |
| LXC  | 117  | CT-Monitors      | Prometheus + Grafana + Alertmanager            | 9090 / 3000    |
| LXC  | 121  | twgsej           | Tailscale + WireGuard + DuckDNS                | Tailscale      |
| Dock | –    | guacamole        | Apache Guacamole (RDP/SSH/VNC web)             | 9080           |
| Dock | –    | dvwa_lab         | Damn Vulnerable Web Application                | 9001           |
| + más contenedores en pruebas (vortex-api, vortex-ml, vortex-dash, etc.)

## Diagrama de red (texto)
Internet
↓ 
(DuckDNS + Cloudflare Tunnel opcional)
Tailscale (100.x.x.x) ←→ twgsej (LXC 121)
↓
Proxmox Host (192.168.100.10)

├─ LXC 110-121
├─ Docker → Guacamole stack (9080) + DVWA (9001)
└─ VMs (Windows, Kali, etc.)


## Cómo replicar este homelab en otro servidor (WIP)

```bash
# 1. Instala Proxmox VE limpio
# 2. Clona este repo
git clone https://github.com/JohanSE17/SNEP.git && cd SNEP

# 3. Copia y edita variables
cp .env.example .env
nano .env   # ← aquí pones tu DuckDNS token, IPs, etc.

# 4. (Próximamente) Levanta todo con Ansible
ansible-playbook -i inventory/hosts.yml ansible/playbook-main.yml
```
## Licencia
MIT License – Usa, modifica y distribuye libremente, dando crédito a mi como creador y a los compas que hicieron posible todo.
Solo mantén el aviso de copyright si redistribuyes.
# Hecho con ❤️ (y mucho café) desde Colombia por JohanSE17
