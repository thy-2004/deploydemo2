# Build stage
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files trước để cache cài đặt dependency
COPY package*.json ./
RUN npm install

# Copy toàn bộ project
COPY . .

# Build project
RUN npm run build

# Run stage
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app ./

EXPOSE 3000
CMD ["npm", "start"]
