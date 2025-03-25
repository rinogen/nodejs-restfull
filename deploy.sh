#!/bin/bash

# Fungsi untuk deploy
deploy() {
    local env=$1
    
    # Set environment variables
    export NODE_ENV=$env
    
    # Pilih port dan database sesuai environment
    case $env in
        development)
            export PORT=${DEV_PORT}
            export DATABASE_URL=${DEV_DATABASE_URL}
            ;;
        testing)
            export PORT=${TEST_PORT}
            export DATABASE_URL=${TEST_DATABASE_URL}
            ;;
        production)
            export PORT=${PROD_PORT}
            export DATABASE_URL=${PROD_DATABASE_URL}
            ;;
        *)
            echo "Invalid environment"
            exit 1
            ;;
    esac
    
    # Down existing containers
    docker-compose down
    
    # Build dan start ulang
    docker-compose up -d --build
    
    # Migrasi database
    docker-compose exec api npx prisma migrate deploy
}

# Pilih environment
case "$1" in
    dev)
        deploy development
        ;;
    test)
        deploy testing
        ;;
    prod)
        deploy production
        ;;
    *)
        echo "Usage: $0 {dev|test|prod}"
        exit 1
esac