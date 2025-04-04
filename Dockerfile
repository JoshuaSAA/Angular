# Etapa de construcción
FROM node:18 AS build
WORKDIR /app

# Primero copia los archivos necesarios para instalar dependencias
COPY package*.json ./

# Entonces sí, instala dependencias
RUN npm install

# Luego copia el resto del código (evita copiar node_modules, etc.)
COPY . .

# Compila la app Angular
RUN npm run build

# Etapa de producción
FROM nginx:alpine

# Copia los archivos compilados al contenedor de Nginx
COPY --from=build /app/dist/angular-app /usr/share/nginx/html
