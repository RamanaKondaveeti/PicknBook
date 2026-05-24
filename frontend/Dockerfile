# ---------- Stage 1: Build ----------
FROM node:20-alpine AS build
WORKDIR /app

# Build-time API URL
ARG REACT_APP_API_BASE_URL=http://3.108.72.102:5007
ENV REACT_APP_API_BASE_URL=$REACT_APP_API_BASE_URL

# Memory + npm optimizations
ENV NODE_OPTIONS="--max-old-space-size=512"
ENV GENERATE_SOURCEMAP=false
ENV NPM_CONFIG_AUDIT=false
ENV NPM_CONFIG_FUND=false
ENV NPM_CONFIG_PROGRESS=false
ENV NPM_CONFIG_LOGLEVEL=error

# Copy only package files first (cache optimization)
COPY package*.json ./

# Use npm install (less memory than ci)
RUN npm install --prefer-offline --no-audit --progress=false

# Copy rest of the app
COPY . .

# Build with controlled memory
RUN npm run build

# ---------- Stage 2: Runtime ----------
FROM nginx:1.27-alpine AS runtime

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Custom nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy build output
COPY --from=build /app/build /usr/share/nginx/html

# Expose port
EXPOSE 5000

CMD ["nginx", "-g", "daemon off;"]