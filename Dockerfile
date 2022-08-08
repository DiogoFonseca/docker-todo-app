FROM node:12-alpine as build
WORKDIR /app
COPY package.json yarn.lock /app/
RUN yarn install --production


FROM node:12-alpine as production
COPY --from=build /app/node_modules /app/node_modules
COPY . .
CMD ["node", "src/index.js"]
EXPOSE 3000

FROM node:12-alpine as dev
COPY --from=build /app/node_modules /app/node_modules
COPY --from=build /app/package.json /app/yarn.lock /app/
WORKDIR /app
RUN yarn install
EXPOSE 3000
CMD ["yarn", "run", "dev"]