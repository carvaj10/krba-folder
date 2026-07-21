# Karba Portfolio - Deployment Guide

This guide explains how to deploy the Karba Portfolio application using Docker. The application is built with Astro and includes React components.

## 🏗️ Project Overview

- **Framework**: Astro 5.0.2 with React integration
- **Language**: TypeScript
- **Package Manager**: pnpm
- **Build Output**: Static site served by Nginx
- **Containerization**: Multi-stage Docker build

## 📋 Prerequisites

Before deploying, ensure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/) (version 20.10+)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 2.0+)
- [Git](https://git-scm.com/downloads)

## 🚀 Quick Start (Local Development)

### 1. Clone the Repository
```bash
git clone <your-repository-url>
cd karba-folder
```

### 2. Build and Run with Docker Compose
```bash
# Build and start the application
docker-compose up --build

# Run in detached mode
docker-compose up -d --build
```

The application will be available at `http://localhost:3000`

### 3. Stop the Application
```bash
# Stop and remove containers
docker-compose down

# Stop and remove containers, networks, and images
docker-compose down --rmi all
```

## 🐳 Manual Docker Commands

### Build the Docker Image
```bash
docker build -t karba-portfolio .
```

### Run the Container
```bash
docker run -d -p 3000:80 --name karba-portfolio karba-portfolio
```

### Stop and Remove Container
```bash
docker stop karba-portfolio
docker rm karba-portfolio
```

## 🌐 Production Deployment

### Option 1: Docker Compose (Recommended)

1. **Prepare your server**:
   ```bash
   # Update system packages
   sudo apt update && sudo apt upgrade -y
   
   # Install Docker and Docker Compose
   curl -fsSL https://get.docker.com -o get-docker.sh
   sudo sh get-docker.sh
   sudo usermod -aG docker $USER
   ```

2. **Deploy the application**:
   ```bash
   # Clone your repository
   git clone <your-repository-url>
   cd karba-folder
   
   # Build and start
   docker-compose up -d --build
   ```

3. **Set up reverse proxy** (optional):
   ```bash
   # Install Nginx
   sudo apt install nginx -y
   
   # Configure Nginx to proxy to your Docker container
   sudo nano /etc/nginx/sites-available/karba-portfolio
   ```

   Add this configuration:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;
       
       location / {
           proxy_pass http://localhost:3000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
       }
   }
   ```

   Enable the site:
   ```bash
   sudo ln -s /etc/nginx/sites-available/karba-portfolio /etc/nginx/sites-enabled/
   sudo nginx -t
   sudo systemctl reload nginx
   ```

### Option 2: Cloud Platform Deployment

#### Docker Hub
1. **Tag and push your image**:
   ```bash
   docker tag karba-portfolio your-username/karba-portfolio:latest
   docker push your-username/karba-portfolio:latest
   ```

2. **Deploy on any platform that supports Docker**:
   - AWS ECS
   - Google Cloud Run
   - Azure Container Instances
   - DigitalOcean App Platform

#### Vercel (Alternative)
Since this is an Astro application, you can also deploy directly to Vercel:

1. **Install Vercel CLI**:
   ```bash
   npm i -g vercel
   ```

2. **Deploy**:
   ```bash
   vercel --prod
   ```

## 🔧 Configuration

### Environment Variables
The application currently doesn't require environment variables, but you can add them if needed:

```bash
# Create .env file
NODE_ENV=production
PUBLIC_SITE_URL=https://your-domain.com
```

### Nginx Configuration
The `nginx.conf` file includes:
- Gzip compression
- Security headers
- Static asset caching
- SPA routing support
- Health check endpoint

### Port Configuration
- **Container Port**: 80 (internal)
- **Host Port**: 3000 (configurable in docker-compose.yml)

## 📊 Monitoring and Logs

### View Logs
```bash
# Docker Compose logs
docker-compose logs -f karba-portfolio

# Direct container logs
docker logs -f karba-portfolio

# Nginx logs (if using volume mount)
tail -f logs/access.log
tail -f logs/error.log
```

### Health Check
The application includes a health check endpoint:
```bash
curl http://localhost:3000/health
# Should return: healthy
```

### Container Status
```bash
docker ps
docker stats karba-portfolio
```

## 🔒 Security Considerations

The Docker setup includes several security features:
- Non-root user in production
- Security headers in Nginx
- Hidden file access prevention
- Resource limits (configurable)

## 📈 Scaling

### Horizontal Scaling
```bash
# Scale to multiple instances
docker-compose up -d --scale karba-portfolio=3
```

### Load Balancer Configuration
If using multiple instances, configure your load balancer to distribute traffic across ports 3000, 3001, 3002, etc.

## 🚨 Troubleshooting

### Common Issues

1. **Port already in use**:
   ```bash
   # Check what's using the port
   sudo lsof -i :3000
   
   # Kill the process or change the port in docker-compose.yml
   ```

2. **Build failures**:
   ```bash
   # Clean Docker cache
   docker system prune -a
   
   # Rebuild without cache
   docker-compose build --no-cache
   ```

3. **Permission issues**:
   ```bash
   # Fix log directory permissions
   sudo mkdir -p logs
   sudo chown $USER:$USER logs
   ```

### Debug Mode
```bash
# Run with interactive shell
docker run -it --rm -p 3000:80 karba-portfolio /bin/sh

# Check container filesystem
docker exec -it karba-portfolio /bin/sh
```

## 📝 Maintenance

### Update Application
```bash
# Pull latest changes
git pull origin main

# Rebuild and restart
docker-compose up -d --build
```

### Update Dependencies
```bash
# Update package.json dependencies
npm update

# Rebuild container
docker-compose up -d --build
```

### Backup and Restore
```bash
# Backup container
docker export karba-portfolio > karba-portfolio-backup.tar

# Restore container
docker import karba-portfolio-backup.tar karba-portfolio:backup
```

## 🤝 Support

For deployment issues:
1. Check the logs: `docker-compose logs karba-portfolio`
2. Verify Docker is running: `docker info`
3. Check container status: `docker ps -a`
4. Review the configuration files

## 📚 Additional Resources

- [Astro Documentation](https://docs.astro.build/)
- [Docker Documentation](https://docs.docker.com/)
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Docker Compose Documentation](https://docs.docker.com/compose/) 