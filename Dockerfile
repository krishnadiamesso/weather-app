FROM node:22-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
ARG VUE_APP_GEO_TOKEN_API
ARG VUE_APP_OPEN_WEATHER_API
ENV VUE_APP_GEO_TOKEN_API=$VUE_APP_GEO_TOKEN_API
ENV VUE_APP_OPEN_WEATHER_API=$VUE_APP_OPEN_WEATHER_API
RUN npm run build

FROM node:22-alpine
WORKDIR /app
COPY --from=build /app/dist ./dist
COPY --from=build /app/server.js ./
COPY --from=build /app/package.json ./
RUN npm install --omit=dev
EXPOSE 3000
CMD ["node", "server.js"]
