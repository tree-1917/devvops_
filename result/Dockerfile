# ========================== # 
# === Reuslt Docker File === # 
# ========================== # 
# Stage 1: Building Stage 
FROM node:20.19.6-alpine AS builder

WORKDIR /app

COPY package.json .

RUN npm install 
RUN npm audit fix

COPY . .

# Stage 2: Production Stage 
FROM node:20.19.6-alpine

WORKDIR /app

COPY --from=builder /app ./

ENV PORT=8081

EXPOSE 8081

CMD ["npm", "run", "server"]
