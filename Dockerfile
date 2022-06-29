FROM node:14.15.3-alpine as builder

WORKDIR /app
ENV NODE_ENV=production

ADD ./ ./
RUN npm install
RUN npm run build

FROM node:14.15.3-alpine
WORKDIR /app

ENV HOST 0.0.0.0
EXPOSE 5000

COPY --from=builder ./app/package.json ./
COPY --from=builder ./app/nuxt.config.js ./
COPY --from=builder ./app/node_modules ./node_modules/
COPY --from=builder ./app/.nuxt ./.nuxt/
COPY --from=builder ./app/static ./static/

ENV NUXT_PORT=2021
# EXPOSE 2021
CMD ["npm", "run", "start"]
