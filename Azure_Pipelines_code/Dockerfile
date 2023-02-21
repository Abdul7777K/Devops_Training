FROM node:16-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm install -g @angular/cli

RUN ng build --configuration production --output-path=/app/dist/assignment --base-href=/

FROM nginx:latest

COPY --from=0 /app/dist/assignment /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
