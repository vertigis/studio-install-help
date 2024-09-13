---
title: VertiGIS Studio - Containers - Installation
---
# VertiGIS Studio - Containers - Installation

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
> vim docker-compose.yaml
# If using a GUI, try one of these:
> code docker-compose.yaml &
> gedit docker-compose.yaml &
> kate docker-compose.yaml &
> mousepad docker-compose.yaml &

# Gain access to Docker images
# If using user/token, login with docker:
> docker login vertigisapps.azurecr.com
# If using ACR, login with Azure CLI:
> az acr login -n vertigisapps

# Pull/Start VertiGIS Studio
> docker compose up --wait
```

## On Linux: Upgrade to latest
```bash
# If login has expired, gain access to images
# If using user/token, login with docker:
> docker login vertigisapps.azurecr.com
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

# ADMIN: Request Web certificates using Enrollment Services
# This step can be skipped if testing or if no web certificate is needed.
# Refer to the section on using Enrollment Services.
> .\request-web-certs.ps1

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
# Transfer context to remote deploy-studio folder.
> .\rsat-transfer.ps1 user@linux.contoso.com deploy-studio
```
