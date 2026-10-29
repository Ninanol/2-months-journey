WGEL CTF AND RED TEAMING CONCEPT

## TryHackMe - Wgel



URL: https://tryhackme.com <img width="548" height="170" alt="image" src="https://github.com/user-attachments/assets/d8b44284-fe5b-4b4e-a19c-08e8a1052583" />


### 📊 Room Walkthrough
You should deploy the target machine first.

#### 1. Reconnaissance
Run an aggressive `nmap` scan against the target infrastructure to enumerate open network ports:
*   **Port 22:** SSH (Secure Shell remote access control connection)
*   **Port 80:** HTTP (Apache Web Server deployment)

#### 2. Web Enumeration & Initial Access
*   Execute directory brute-forcing with `gobuster` against the primary web server.
*   This directory map enumeration turns up a hidden `/sitemap/` path vector.
*   Auditing deeper inside that subpath exposes an unencrypted `id_rsa` private SSH key downloadable directly via the browser.
*   View the source code comments of the default Apache landing page to discover a plaintext system user string (`jessie`).
*   Set strict secure system file permissions on your local machine (`chmod 600 id_rsa`) and establish a working shell foothold over SSH using that private key configuration.

#### 3. Privilege Escalation (Root Flag Exfiltration)
*   Running `sudo -l` shows the authenticated user account can execute a common web download utility (`wget`) as root with `NOPASSWD` rules.
*   Instead of attempting an complex local exploit chain, leverage the privileged `wget` tool binary to stream the root flag directly back out to a local netcat listener interface to exfiltrate the target data.

---

### 🔗 Further Resources
*   [Detailed Medium Writeup Reference by @darkwalkers](https://medium.com)
