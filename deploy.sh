#!/bin/bash

# Karba Portfolio Deployment Script
# This script automates the deployment process for the portfolio application

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
CONTAINER_NAME="karba-portfolio"
IMAGE_NAME="karba-portfolio"
PORT=3000

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_error "Docker is not running. Please start Docker and try again."
        exit 1
    fi
    print_success "Docker is running"
}

# Function to check if Docker Compose is available
check_docker_compose() {
    if ! command -v docker-compose &> /dev/null; then
        print_error "Docker Compose is not installed. Please install Docker Compose and try again."
        exit 1
    fi
    print_success "Docker Compose is available"
}

# Function to stop and remove existing containers
cleanup_existing() {
    print_status "Cleaning up existing containers..."
    
    if docker ps -a --format "table {{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        print_status "Stopping existing container: ${CONTAINER_NAME}"
        docker stop ${CONTAINER_NAME} || true
        docker rm ${CONTAINER_NAME} || true
        print_success "Existing container removed"
    else
        print_status "No existing container found"
    fi
}

# Function to build the Docker image
build_image() {
    print_status "Building Docker image..."
    
    if docker build -t ${IMAGE_NAME} .; then
        print_success "Docker image built successfully"
    else
        print_error "Failed to build Docker image"
        exit 1
    fi
}

# Function to run the container
run_container() {
    print_status "Starting container..."
    
    if docker run -d \
        --name ${CONTAINER_NAME} \
        -p ${PORT}:80 \
        --restart unless-stopped \
        ${IMAGE_NAME}; then
        print_success "Container started successfully"
    else
        print_error "Failed to start container"
        exit 1
    fi
}

# Function to check container health
check_health() {
    print_status "Checking container health..."
    
    # Wait a bit for the container to fully start
    sleep 5
    
    if docker ps --format "table {{.Names}}\t{{.Status}}" | grep -q "${CONTAINER_NAME}.*Up"; then
        print_success "Container is running and healthy"
        
        # Test the health endpoint
        if curl -s http://localhost:${PORT}/health > /dev/null; then
            print_success "Application is responding to health checks"
        else
            print_warning "Health check endpoint not responding yet (this is normal during startup)"
        fi
    else
        print_error "Container is not running properly"
        docker logs ${CONTAINER_NAME}
        exit 1
    fi
}

# Function to show deployment info
show_info() {
    echo
    print_success "Deployment completed successfully!"
    echo
    echo "Application Information:"
    echo "  - Container Name: ${CONTAINER_NAME}"
    echo "  - Image Name: ${IMAGE_NAME}"
    echo "  - Port: ${PORT}"
    echo "  - URL: http://localhost:${PORT}"
    echo
    echo "Useful Commands:"
    echo "  - View logs: docker logs -f ${CONTAINER_NAME}"
    echo "  - Stop container: docker stop ${CONTAINER_NAME}"
    echo "  - Remove container: docker rm ${CONTAINER_NAME}"
    echo "  - Check status: docker ps"
    echo
}

# Function to deploy using Docker Compose
deploy_compose() {
    print_status "Deploying using Docker Compose..."
    
    if docker-compose up -d --build; then
        print_success "Docker Compose deployment successful"
    else
        print_error "Docker Compose deployment failed"
        exit 1
    fi
}

# Function to show help
show_help() {
    echo "Karba Portfolio Deployment Script"
    echo
    echo "Usage: $0 [OPTION]"
    echo
    echo "Options:"
    echo "  -h, --help     Show this help message"
    echo "  -c, --compose  Deploy using Docker Compose (recommended)"
    echo "  -d, --docker   Deploy using Docker commands only"
    echo "  -s, --stop     Stop and remove the container"
    echo "  -l, --logs     Show container logs"
    echo "  -r, --restart  Restart the container"
    echo
    echo "Examples:"
    echo "  $0 -c          # Deploy using Docker Compose"
    echo "  $0 -d          # Deploy using Docker commands"
    echo "  $0 -s          # Stop the application"
    echo "  $0 -l          # Show logs"
}

# Function to stop the application
stop_application() {
    print_status "Stopping application..."
    
    if docker ps --format "table {{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        docker stop ${CONTAINER_NAME}
        docker rm ${CONTAINER_NAME}
        print_success "Application stopped and removed"
    else
        print_status "Application is not running"
    fi
}

# Function to show logs
show_logs() {
    if docker ps --format "table {{.Names}}" | grep -q "^${CONTAINER_NAME}$"; then
        docker logs -f ${CONTAINER_NAME}
    else
        print_error "Container is not running"
        exit 1
    fi
}

# Function to restart the application
restart_application() {
    print_status "Restarting application..."
    stop_application
    deploy_compose
}

# Main script logic
main() {
    case "${1:-}" in
        -h|--help)
            show_help
            exit 0
            ;;
        -c|--compose)
            check_docker
            check_docker_compose
            deploy_compose
            show_info
            ;;
        -d|--docker)
            check_docker
            cleanup_existing
            build_image
            run_container
            check_health
            show_info
            ;;
        -s|--stop)
            check_docker
            stop_application
            ;;
        -l|--logs)
            check_docker
            show_logs
            ;;
        -r|--restart)
            check_docker
            check_docker_compose
            restart_application
            ;;
        "")
            # Default to Docker Compose deployment
            check_docker
            check_docker_compose
            deploy_compose
            show_info
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

# Run main function with all arguments
main "$@" 