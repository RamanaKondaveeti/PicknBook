FROM node:20-alpine AS build
WORKDIR /app

ARG REACT_APP_API_BASE_URL=http://3.108.72.102:5007
ENV REACT_APP_API_BASE_URL=$REACT_APP_API_BASE_URL
ENV NODE_OPTIONS="--max-old-space-size=768"
ENV GENERATE_SOURCEMAP=false
ENV NPM_CONFIG_AUDIT=false
ENV NPM_CONFIG_FUND=false
ENV NPM_CONFIG_PROGRESS=false
ENV NPM_CONFIG_LOGLEVEL=error

COPY package*.json ./
RUN npm ci --prefer-offline && npm cache clean --force

COPY . .
RUN npm run build

FROM nginx:1.27-alpine AS runtime
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 5000

CMD ["nginx", "-g", "daemon off;"]
