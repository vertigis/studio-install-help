---
title: VertiGIS Studio - Containers - Installation
---
## System Requirements

| Requirement  | Spec                                                                           |
|--------------|--------------------------------------------------------------------------------|
| OS           | Linux                                                                          |
| Distribution | Ubuntu 24.04, Ubuntu 22.04, or Debian 12 (bookworm)                            |
| Memory       | 4 GB Minimum, 8 GB Preferred                                                   |
| Disk         | 16 GB Free                                                                     |

## Get the Package

| Links |                                                                                       |
|-------|---------------------------------------------------------------------------------------|
| TGZ   | [deploy-studio.tgz](https://vertigis.github.io/studio-install-help/deploy-studio.tgz) |
| ZIP   | [deploy-studio.zip](https://vertigis.github.io/studio-install-help/deploy-studio.zip) |

```bash
> mkdir -p deploy-studio
> cd deploy-studio
> curl -fsSL https://vertigis.github.io/studio-install-help/deploy-studio.tgz | tar -xz
```

```cmd
> mkdir deploy-studio
> cd deploy-studio
> curl -fsSL https://vertigis.github.io/studio-install-help/deploy-studio.tgz -o deploy-studio.tgz
> tar -xzf deploy-studio.tgz
> del deploy-studio.tgz
```

```powershell
> mkdir deploy-studio
> cd deploy-studio
> iwr -Uri https://vertigis.github.io/studio-install-help/deploy-studio.zip -OutFile deploy-studio.zip
> exa -Path deploy-studio.zip -DestinationPath .
> del deploy-studio.zip
```

```git
> git clone https://github.com/vertigis/studio-install-help deploy-studio
> cd deploy-studio
```

## On Linux: Initial Setup
```bash
# Install Docker and supporting tools
> sudo ./install-tools.sh

# Edit configuration for VertiGIS Studio
# If using a plain terminal, try one of these:
> nano docker-compose.yaml
> vi docker-compose.yaml
# If using a GUI, try one of these:
> code docker-compose.yaml &
> gedit docker-compose.yaml &
> kate docker-compose.yaml &
> mousepad docker-compose.yaml &

# Gain access to images
# If using user/token, login with docker:
> docker login vertigisapps.azurecr.io
# If using ACR, login with Azure CLI:
> az acr login -n vertigisapps

# Pull/Start VertiGIS Studio
> docker compose up --wait
```

## On Linux: Upgrade to Latest
```bash
# If login has expired, gain access to images
# If using user/token, login with docker:
> docker login vertigisapps.azurecr.io
# If using ACR, login with Azure CLI:
> az acr login -n vertigisapps

# Pull down VertiGIS Studio
> docker compose pull

# Upgrade/Restart VertiGIS Studio
> docker compose up --wait
```

## On Windows: Initial Setup
```powershell
# ADMIN: Install required tools
> .\install-tools.ps1

# Extract CA certificates from Active Directory
# Some environments may use an internal CA system.
# This will enable systems to communicate over HTTPS in this situation.
> .\extract-ca-certs.ps1

# Edit configuration for VertiGIS Studio
> code docker-compose.yaml
> notepad docker-compose.yaml

# Create SSH key
> ssh-keygen -t ed25519

# Enable passwordless SSH
> .\rsat-auth.ps1 user@linux.contoso.com
```

## On Windows: Login via SSH
```powershell
# ADMIN: Request Web certificates using Enrollment Services
# This step can be skipped if testing or if no web certificate is needed.
# Refer to the section on using Enrollment Services.
> .\request-web-certs.ps1

# Transfer context to remote deploy-studio folder.
> .\rsat-transfer.ps1 user@linux.contoso.com deploy-studio
```
### Continue Setup on Linux
- [Initial Setup](#on-linux-initial-setup)
- [Upgrade to Latest](#on-linux-upgrade-to-latest)

## Give the Container a Web Certificate
Some Windows enterprise environments require using internal
CA services for secure communication. If you plan on using
Studio as a frontend, you'll want to give the container a
real web certificate. Your IT professional can likely help
with this, but you can likely do this yourself.

### Provide a Web Certificate Directly
- Edit the `docker-compose.yaml` file
- Adjust the `WEB_CERT` setting
  - `host` is the default value
- Go to the `web-certs` folder
  - Place the `.pfx` file here
  - Give this file a name like `host_<id>.pfx`
- Update your deployment (see [here](#on-linux-upgrade-to-latest))

### Use Enrollment Services (Windows Only)
- Edit the `docker-compose.yaml` file
- Adjust the `WEB_CERT` setting
  - `host` is the default value
- Go to the `web-certs` folder
  - Copy the `sample.inf` file to `host.inf`
  - Remove the `sample.inf` file
  - Edit the `host.inf` file (reference [here](#reference-inf-file))
  - Adjust the Subject
  - Adjust the DNS names
  - Save this file
- Update your deployment (see [here](#on-windows-login-via-ssh))

### Reference INF file
```inf
[NewRequest]
Subject = "CN=System Name, O=Example Corp, OU=IT Department, L=New York, ST=New York, C=US"
...

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "dns=server1.contoso.com&"
_continue_ = "dns=server2.contoso.com"
...
```

## Using Studio as a Reverse Proxy
For convenience, the Studio image provides a means of using the internal
NGINX server as a reverse proxy. You can take advantage of this for
whatever needs you have. Simply edit the `server/nginx.conf` file.
