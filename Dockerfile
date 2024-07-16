# Dockerfile

# Stage 1: Build
FROM node:18-alpine AS build

WORKDIR /app

COPY ./package*.json /app/
RUN npm install && npm cache clean --force

COPY . .

RUN npm run build

# Stage 2: Production
FROM node:18-alpine AS production

WORKDIR /app

COPY --from=build /app ./

EXPOSE 3000

CMD ["npm", "run", "dev"]
