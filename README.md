# JupyterHub+JupyterLab+IJava

A jupyter notebook environment with multi-language support and jupyterhub for user authentication.

## Overview

This project sets up a comprehensive JupyterHub development environment with multi-language support, featuring:

- JupyterHub as the core platform
- Java development environment
- Jupyter and JupyterLab interfaces
- IJava kernel for Java programming
- JupyterLite JavaScript kernel

## Prerequisites

Before you begin, ensure you have the following installed:

- Docker (version 20.10 or later)
- Docker Compose (version 1.29 or later)
- Git (optional, for cloning the repository)


## Project Structure

```txt

├── Dockerfile          # Container build instructions
├── docker-compose.yml  # Docker Compose configuration
├── nginx.conf          # Nginx reverse proxy configuration
├── jupyterhub_config.py  # JupyterHub configuration
├── data           # Data volumes to persist data
└── ssl           # SSL certificates
```

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/aminnez/jupyterbook.git
cd jupyterbook
```

### 2. Build and Start the Environment

```bash
# Build and start the containers in detached mode
docker-compose up -d

# View running containers
docker-compose ps
```

### 3. Access JupyterBook

- **URL:** `https://example.com`
- **Default Login:** Follow the authentication setup instructions in the documentation
- **Supported Languages:** 
  - Python (default)
  - Java (via IJava kernel)
  - JavaScript (via JupyterLite)

## Configuration

### User Authentication

1. **Create Users:** Add users to the `allowed_users` list in the `jupyterhub_config.py` file
2. **Admin Users:** Add admin users to the `admin_users` list

#### Passwords

This project uses LocalAuthenticator, which requires a password for each user. The password is set in the container.

First, run the container in interactive mode:

```bash
docker exec -it jupyterbook-hub bash
```
Then, set the password for a user:

```bash
passwd amin
```

### Ports
change the port in the `docker-compose.yml` file if necessary.

### Nginx Configuration

Generate SSL certificates for the nginx reverse proxy and add fullchain.pem and privkey.pem files to the `ssl` directory.

### Adding More Kernels

To add additional programming language support, update the `Dockerfile` with the appropriate kernel installation commands.

## Development Workflow

1. Make changes to project files
2. Rebuild the container:
   ```bash
   docker-compose down
   docker-compose up -d --build
   ```

## Troubleshooting

- **Connection Issues:** Ensure ports 8000 are not blocked by other services
- **Permission Errors:** Run with `sudo` if encountering permission problems
- **Container Logs:** 
  ```bash
  docker-compose logs
  ```

## Security Considerations

- Change default authentication methods
- Use environment variables for sensitive configurations
- Regularly update base images and dependencies

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License. 

Copyright (c) 2025 Amin Nezampour

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files, to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software.

See the [LICENSE.md](LICENSE.md) file for complete license details.

## Contact

[aminnez.com](https://aminnez.com)