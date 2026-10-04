# Infrastructure as Code (IaC) | 42 Cloud-1 Project

> *"There is no cloud, it’s just someone else’s computer."*

This project automates the deployment of a secure, production-ready web infrastructure (WordPress, MariaDB, phpMyAdmin behind an Nginx reverse proxy with TLS) on cloud virtual machines (AWS EC2, GCP, Azure, or local VMs) using **Ansible** and **Docker Compose**.

---

## Project Requirements & Status

| Requirement | Description | Status |
| :--- | :--- | :---: |
| **Cloud Deployment** | Runnable on cloud instances (AWS / GCP / Azure) | 🔄 Pending Cloud Provisioning |
| **Port Restrictions** | Only ports 22 (SSH), 80 (HTTP), and 443 (HTTPS) open via UFW | ✅ Configured |
| **Containerization** | Docker Engine + Docker Compose integration | ✅ Configured |
| **Auto-restart** | Containers & services restart automatically on host reboot | ✅ Configured (`restart: always`) |
| **Data Persistence** | Volume persistence across host/container reboots | ✅ Configured (Named Docker volumes) |
| **TLS/HTTPS** | Nginx SSL/TLS termination with automatic HTTP -> HTTPS redirect | ✅ Configured |
| **Multi-instance Support** | Parallel deployment across multiple inventory target hosts | ✅ Supported |
| **Ansible Roles** | Modular role structure (`common`, `firewall`, `docker`, `stack`) | ✅ Implemented |
| **Idempotency** | Ansible playbooks can run repeatedly without unintended side effects | 🔄 Pending Verification |
| **Secrets Management** | Zero hardcoded secrets; encrypted via Ansible Vault | ⏳ In Progress |

---


## Task Completion Checklist

Track progress on remaining implementation and verification tasks below:

### 1. Secrets & Security Setup
- [ ] Create Ansible Vault encrypted file (`group_vars/all/vault.yml`) to store DB passwords & secrets.
- [ ] Remove any draft `.env` or plain text credentials from repository tracking.
- [ ] Add Jinja2 template (`.env.j2`) inside `roles/stack/templates/` to dynamically generate `.env` on target server.

### 2. Automation & TLS Integration
- [ ] Automate self-signed TLS certificate generation in Ansible (`roles/stack`) if certs are missing on target host.
- [ ] Ensure relative pathing in `roles/stack/main.yml` is robust regardless of execution CWD.

### 3. Inventory & Cloud Provisioning
- [ ] Provision cloud server instance (AWS EC2, GCP, or Azure).
- [ ] Configure `inventory/prod.ini` with target server public IP and SSH key parameters.
- [ ] Verify SSH key access to target host from local control machine.

### 4. Deployment & Idempotency Testing
- [ ] Execute full playbook deployment:
  ```bash
  ansible-playbook -i inventory/prod.ini site.yml --ask-vault-pass
  ```
- [ ] Run idempotency test (re-execute playbook and ensure zero unexpected changes).
- [ ] Audit open ports with `nmap` or `ufw status` to confirm only 22, 80, and 443 are reachable.

### 5. Verification & Persistence Validation
- [ ] Verify HTTP automatically redirects to HTTPS (`http://<SERVER_IP>` -> `https://<SERVER_IP>`).
- [ ] Complete initial WordPress installation setup in web browser.
- [ ] Access phpMyAdmin interface at `https://<SERVER_IP>/phpmyadmin/`.
- [ ] Perform host reboot (`sudo reboot`) and confirm:
  - Docker daemon and stack start automatically on boot.
  - WordPress data and database records are preserved intact.

---

## 🛠️ Usage Quick Start

### 1. Requirements
- Ansible `core >= 2.15`
- OpenSSH installed on local machine and remote servers

### 2. Run Playbook
```bash
# Run against development / local inventory
ansible-playbook -i inventory/dev.ini site.yml

# Run against production inventory with Ansible Vault
ansible-playbook -i inventory/prod.ini site.yml --ask-vault-pass
```




