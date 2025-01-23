# JupyterHub+JupyterLab+Java+Dart+Typescript

## Overview

A comprehensive [Jupyter](https://jupyter.org/) notebook environment with multi-language support including Java, Python, Dart, JavaScript/Typescript, and Zsh featuring [JupyterHub](https://github.com/jupyterhub/jupyterhub) for user authentication.

- [JupyterHub](https://github.com/jupyterhub/jupyterhub) as the core platform for multi-user support.
- [Jupyter](https://jupyter.org/) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) as the primary interfaces.
- Java programming via the [IJava](https://github.com/SpencerPark/IJava) kernel.
- Dart programming via the [Dart Kernel](https://github.com/vickumar1981/jupyter-dart-kernel.git) kernel.
- JavaScript/Typescript programming via the [tslab](https://github.com/yunabe/tslab) kernel.
- Zsh with [Oh My Zsh](https://ohmyz.sh/) as the default shell.

## Prerequisites

Ensure you have the following installed before starting:

- Docker (version 20.10 or later)
- Docker Compose (version 1.29 or later)
- Git (optional, for cloning the repository)

## Project Structure

```txt
├── Dockerfile          # Container build instructions
├── docker-compose.yml  # Docker Compose configuration
├── nginx.conf          # Nginx reverse proxy configuration
├── jupyterhub_config.py  # JupyterHub configuration
├── data                # Data volumes to persist data
└── ssl                 # SSL certificates
```

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/aminnez/jupyterbook.git
cd jupyterbook
```

### 2. Configure Nginx

- **Replace** `example.com` with your desired domain in `nginx.conf`.
- **Generate SSL** certificates for the Nginx reverse proxy and place `fullchain.pem` and `privkey.pem` in the `ssl` directory.

```bash
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 \
   -keyout ./ssl/privkey.pem \
   -out ./ssl/fullchain.pem

#OR

acme.sh --install-cert -d example.com \
   --key-file       ./ssl/privkey.pem  \
   --fullchain-file ./ssl/fullchain.pem
```

### 3. Build and Start the Environment

```bash
# Build and start the containers in detached mode
docker compose up -d

# View running containers
docker compose ps
```

### 4. Access JupyterBook

- **URL:** `http://localhost:8000` (or `https://example.com` if using hosted one)
- **Supported Languages:**
  - Python (default)
  - Java (via IJava kernel)
  - Dart (via Dart Kernel)
  - JavaScript/Typescript (via tslab kernel)
  - Zsh (default shell)

## Configuration

### Google OAuth Configuration

1. **Create Google OAuth Credentials:**
   - Go to the [Google Cloud Console](https://console.cloud.google.com/)
   - Create a new project or select an existing project
   - Navigate to `APIs & Services` > `Credentials`
   - Click `Create Credentials` > `OAuth client ID`
   - Choose `Web application` as the application type
   - Add your domain (e.g., `https://example.com`) to the Authorized JavaScript origins
   - Add `https://example.com/hub/oauth_callback` to the Authorized redirect URIs
   - Save the client ID and client secret

2. **Set Environment Variables:**
   Create a `.env` file in the project root with your Google OAuth credentials:

   ```bash
   GOOGLE_OAUTH_CLIENT_ID=your_client_id
   GOOGLE_OAUTH_CLIENT_SECRET=your_client_secret
   OAUTH_CALLBACK_URL=https://example.com/hub/oauth_callback
   ```

3. **User Restrictions:**
   - Uncomment and modify the `admin_users` and `allowed_users` lines in `jupyterhub_config.py` to restrict access to specific users.

### Port Configuration

To change the port, update the `docker-compose.yml` file as necessary.

## Development Workflow

1. Make changes to project files.
2. Rebuild the container:

   ```bash
   docker compose down
   docker compose up -d --build
   ```

## Troubleshooting

- **Permission Errors:** Run with `sudo` if encountering permission problems.
- **Container Logs:**

  ```bash
  docker compose logs
  ```

## Security Considerations

- Change default authentication methods.
- Use environment variables for sensitive configurations.
- Regularly update base images and dependencies.

## Contributing

1. Fork the repository.
2. Create a feature branch.
3. Commit your changes.
4. Push to the branch.
5. Create a Pull Request.

## License

This project is licensed under the MIT License.

Copyright (c) 2025 Amin Nezampour

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files, to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.

See the [LICENSE.md](LICENSE.md) file for complete license details.

## Contact

[aminnez.com](https://aminnez.com)