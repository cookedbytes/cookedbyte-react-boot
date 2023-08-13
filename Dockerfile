# Stage 1: Build the Frontend
FROM node:14 as frontend-builder

WORKDIR /app

# Copy package.json and package-lock.json
COPY react-front/package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the React app's source code
COPY react-front .

# Build the React app
RUN npm run build

################################ End of stage 1 #############################

# Stage 2: Build the Backend
FROM gradle:7.5-jdk17-alpine AS backend-builder
COPY --chown=gradle:gradle . /home/gradle/workspace
WORKDIR /home/gradle/workspace

# Copy the frontend build artefact into backend resources folder to serve frontend from backend server. This is to support monolithic architecture and microfrontend
COPY --from=frontend-builder /app/build ./react-front/build

RUN cd boot-backend && gradle clean build --no-daemon

############################### End of stage 2 ###############################

# Stage 3: Build final deployable image
FROM openjdk:17-jdk-slim

EXPOSE 8080

RUN mkdir /application

COPY --from=backend-builder /home/gradle/workspace/boot-backend/build/libs/*.jar /app/application.jar

ENTRYPOINT ["java","-Dspring.profiles.active=dev","-jar","/app/application.jar"]