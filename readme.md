```md
# Free SSL Generator and Renewal Bash Script

## Overview

This bash script automates the generation and renewal of free SSL certificates using **Let's Encrypt (Certbot)**. It ensures your website has valid, secure HTTPS encryption by generating **PEM** and **PFX** certificate formats.

## Features

- Automatically generates SSL certificates for a given domain.
- Uses Let's Encrypt's **standalone** mode (ensure ports 80 and 443 are available).
- Concatenates the private key and certificate into a **PEM** file.
- Converts the certificate into a **PFX** format for easy import.
- Ensures correct file permissions.

## Prerequisites

- A **Linux server** with root access.
- A **domain name** pointing to your server’s public IP.
- **Certbot** installed (`sudo apt install certbot` for Debian-based systems).
- Open **ports 80 and 443** to allow Let's Encrypt validation.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/av1-is-better/Free_SSL_Generator_and_Renewal_Bash_Script.git
   cd Free_SSL_Generator_and_Renewal_Bash_Script
   ```

2. Ensure the script is executable:
   ```bash
   chmod +x generate_ssl.sh
   ```

## Usage

1. Open the script in an editor:
   ```bash
   nano generate_ssl.sh
   ```
   - Replace `DOMAIN="domain.example.com"` with your actual domain.
   - Update `EMAIL="your-email@gmail.com"` for certificate notifications.
   - (Optional) Set `PASS="your-password"` for the PFX certificate.

2. Run the script as **root**:
   ```bash
   sudo ./generate_ssl.sh
   ```

3. If successful, the certificates will be available at:
   ```
   /etc/letsencrypt/live/your-domain/
   ```

## Renewal

Let's Encrypt certificates are valid for 90 days. To renew automatically, set up a **cron job**:
```bash
sudo crontab -e
```
Add the following line to renew every 60 days:
```bash
0 0 */60 * * /path/to/generate_ssl.sh >> /var/log/ssl_renew.log 2>&1
```

## Notes

- Ensure **no other services (like Apache or Nginx)** are using ports 80 or 443 when running this script.
- This script is intended for **subdomains only**, not wildcard certificates.
- If using PFX format, remember the password set in `PASS` variable.

## License

This project is licensed under the **MIT License**. Feel free to use and modify it as needed.

---

### Author

Kunal Yadav
https://github.com/av1-is-better  
```

Let me know if you need any modifications! 🚀