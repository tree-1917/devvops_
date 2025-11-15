# ========================== # 
# === Reuslt Docker File === # 
# ========================== # 
# Stage 1: Building Stage 
FROM node:20.11.0-alpine AS builder

WORKDIR /app

COPY package.json .

RUN npm install 
RUN npm audit fix

COPY . .

# Stage 2: Production Stage 
FROM node:20.11.0-alpine

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 4000

CMD ["npm", "run", "server"]
