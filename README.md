# Ansible Web Stack Deployment

Idempotent Ansible automation for production-ready web stack deployment. Transforms manual hour-long process into **reliable 5-minute one-command deployment**.

## Stack Components

- **Nginx** - Web server with SSL/performance optimization
- **MySQL** - Database with security hardening
- **PHP-FPM** - Application runtime with tuning
- **UFW Firewall** - Security configuration
- **Node Exporter** - Monitoring metrics
- **Application** - Laravel/PHP app deployment

## Quick Start

1. **Configure inventory**
   ```bash
   # Edit inventory/production with your server IPs
   vim inventory/production
   ```

2. **Set vault password**
   ```bash
   echo "your_vault_password" > .vault_pass
   chmod 600 .vault_pass
   ```

3. **Create secrets**
   ```bash
   ansible-vault create group_vars/vault.yml
   ```
   Add:
   ```yaml
   vault_mysql_root_password: "secure_password"
   vault_mysql_user: "app_user"
   vault_mysql_password: "user_password"
   ```

4. **Deploy**
   ```bash
   chmod +x scripts/deploy.sh
   ./scripts/deploy.sh
   ```

## Deployment Options

| Command | Description |
|---------|-------------|
| `./scripts/deploy.sh` | Full stack deployment |
| `./scripts/deploy.sh site.yml inventory/production deploy` | App deployment only |
| `ansible-playbook site.yml --tags nginx` | Specific component |

## Project Structure

```
ansible-webstack/
├── ansible.cfg              # Ansible configuration
├── inventory/production     # Server inventory
├── group_vars/all.yml      # Global variables
├── site.yml                # Main playbook
├── roles/                  # Ansible roles
│   ├── common/            # System setup
│   ├── nginx/             # Web server
│   ├── mysql/             # Database
│   ├── php/               # PHP-FPM
│   ├── application/       # App deployment
│   ├── firewall/          # Security
│   └── monitoring/        # Metrics
└── scripts/deploy.sh      # Deployment script
```

## Configuration

Edit `group_vars/all.yml` for:
- Domain name
- Application settings
- PHP/MySQL versions
- Security configurations

## Features

✅ **Idempotent** - Safe to run multiple times  
✅ **Production-ready** - Security hardening included  
✅ **Monitoring** - Node Exporter integration  
✅ **SSL-ready** - HTTPS configuration  
✅ **Performance** - Optimized configurations  
✅ **Backup** - Automated backup setup  

## Requirements

- Ansible 2.9+
- Ubuntu/Debian target servers
- SSH key authentication
- Sudo access on targets

## Post-Deployment

- **Web**: `http://your-domain.com`
- **Monitoring**: `http://your-server:9100/metrics`
- **Logs**: `/var/log/nginx/`, `/var/log/mysql/`

## Troubleshooting

```bash
# Check service status
ansible webservers -m service -a "name=nginx state=started"

# Test connectivity
ansible all -m ping

# View logs
ansible webservers -m shell -a "tail -f /var/log/nginx/error.log"
```