# Gunakan base image Node.js
FROM node:20-bookworm

# Set work directory di dalam container
WORKDIR /app

# Copy package.json dan package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy seluruh source code ke dalam container
COPY . .

# Generate Prisma Client
RUN npx prisma generate

# Install PM2 jika digunakan
RUN npm install pm2 -g

# Expose port (ganti sesuai backend-mu)
EXPOSE 3000

# Jalankan aplikasi dengan PM2
CMD ["pm2-runtime", "start", "ecosystem.config.cjs"]# Gunakan base image Node.js berbasis Debian
FROM node:20-bookworm

# Set working directory di dalam container
WORKDIR /app

# Install dependencies sistem yang diperlukan
RUN apt update && apt install -y openssl libssl-dev libc6

# Copy package.json dan package-lock.json sebelum install dependencies
COPY package*.json ./

# Install dependencies (tanpa devDependencies jika untuk production)
RUN npm install

# Copy seluruh source code ke dalam container
COPY . .

# Generate Prisma Client agar sesuai dengan lingkungan container
RUN npx prisma generate

# Install PM2 untuk menjalankan aplikasi
RUN npm install -g pm2

# Expose port (sesuaikan dengan aplikasi backend)
EXPOSE 3000

# Jalankan aplikasi dengan PM2 menggunakan ecosystem config
CMD ["pm2-runtime", "start", "ecosystem.config.cjs"]

