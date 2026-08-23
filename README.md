# Infrastructure as Code (IaC) | 42 project

First of all, there is no cloud it’s just someone else’s computer.

The projects consists of writing a deployment service using Ansible (or equivalent), this script must run on a real server using one of the available services like AWS, GCP or Azure.

The requirements as follows:
- The deployed site should restart automatically if the server is rebooted.
- The data should be preserved if the server is rebooted.
- We should be able to deploy the site on several instances parallel.
- Public access to the server must be secure and limited.
- We must use Docker + Docker Compose.
- We must use TLS.
- Only ports 80 (HTTP), 443 (HTTPS), and 22 (SSH) must be accessible from out-
side. All other ports should be blocked.
- The Ansible code should be organized into relevant roles for maintainability and should be portable and able to deploy the application on a fresh instance, not only the one you used to develop.
- Your installation code must be idempotent: running it several times must produce
the same working result.
- Your code must NOT contain any hard-coded secrets (for example, a database
password written directly in the code).


