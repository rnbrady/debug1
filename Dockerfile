FROM node:14-alpine AS stage1
WORKDIR /app
COPY . .

FROM node:14-alpine as frontend
WORKDIR /www
COPY --from=stage1 /app/frontend .
RUN yarn global add http-server
ARG code_version=development
RUN echo $code_version >> index.html
CMD http-server 
EXPOSE 8080

FROM node:14-alpine as backend
WORKDIR /api
COPY --from=stage1 /app/backend .
RUN yarn global add http-server
ARG code_version=development
RUN echo $code_version >> index.html
CMD http-server -p 3000
EXPOSE 3000




