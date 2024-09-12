---
title: VertiGIS Studio - Contaienrs - Installation
---
# VertiGIS Studio - Contaienrs - Installation

### Get the Package
```bash
# For bash:
# TODO: Host name is placeholder
> curl -fsSL https://get-studio.vertigisstudio.com | tar -xz
```
```powershell
# For powershell:
# TODO: Host name is placeholder
> iwr -Uri https://get-studio.vertigisstudio.com -OutFile vgs.tgz; tar -xzf vgs.tgz; del vgs.tgz
```

### On Linux
```bash
# Install Docker and supporting tools
# Skip if already done.
# This may ask you for sudo access
> ./install-tools.sh

# Edit configuration for VertiGIS Studio
# Skip if already done.
> ./configure-studio.sh

# Gain access to images
# Skip if already done or login has expired.
# TODO: Host/repo name is placeholder
# If using user/token, login with this command:
> docker login images.vertigisstudio.com
# If using ACR, login with this command instead:
> az acr login -n repo

# Pull down VertiGIS Studio image(s)
# If intending to upgrade, do this step.
# Pulling new images will not interfere with running containers.
> docker compose pull

# Get VertiGIS Studio running
# Newly pulled images will be running after this command.
> docker compose up --wait
```

### On Windows: Install Remotely over SSH
```powershell
# Install required tools: Powershell extensions and SSH
# Skip if already done.
# Local Admin required
> .\install-tools.ps1

# Optional: Request Web certificates from Enrollment Services
# Review section on how to request web certs from Enrollment Services.
# Local Admin required
> .\request-web-certs.ps1

# Optional: Extract CA certificates from Active Directory
# Allows for enterprise systems to use HTTPS properly.
> .\extract-ca-certs.ps1

# Edit configuration for VertiGIS Studio
> .\configure-studio.ps1

# Create SSH key
# Do this once per user per machine.
> ssh-keygen -t ed25519

# Copy SSH identity to remote Linux host
# This will enable passwordless authentication.
# Do this once per user per machine per remote.
> .\rsat-auth.ps1 user@linux.contoso.com

# Remote into Linux host
# Transfer context to deploy-studio folder.
# Continue with the installation using steps from "On Linux".
> .\rsat-transfer.ps1 user@linux.contoso.com deploy-studio
```
