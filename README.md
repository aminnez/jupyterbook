# JupyterHub+JupyterLab+IJava

## Overview

A comprehensive [Jupyter](https://jupyter.org/) notebook environment with support for both Java and Python, featuring [JupyterHub](https://github.com/jupyterhub/jupyterhub) for user authentication.

- [JupyterHub](https://github.com/jupyterhub/jupyterhub) as the core platform for multi-user support.
- [Jupyter](https://jupyter.org/) and [JupyterLab](https://jupyterlab.readthedocs.io/en/stable/) as the primary interfaces.
- Java programming via the [IJava](https://github.com/SpencerPark/IJava) kernel.

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

### 3. Build and Start the Environment

```bash
# Build and start the containers in detached mode
docker compose up -d

# View running containers
docker compose ps
```

### 4. Access JupyterBook

- **URL:** `https://example.com`
- **Default Login:** Follow the authentication setup instructions in the documentation.
- **Supported Languages:**
  - Python (default)
  - Java (via IJava kernel)

## Configuration

### User Authentication

1. **Create Users:** Add users to the `allowed_users` list in the `jupyterhub_config.py` file.
2. **Admin Users:** Add admin users to the `admin_users` list.

#### Setting Passwords

This project uses local authentication, requiring a password for each user. Set the password inside the container:

1. Run the container in interactive mode:

   ```bash
   docker exec -it jupyterbook-hub bash
   ```

2. Set the password for a user:

   ```bash
   passwd amin
   ```

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

- **Connection Issues:** Ensure port `8000` is not blocked by other services.
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
