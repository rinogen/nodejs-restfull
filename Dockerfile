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
