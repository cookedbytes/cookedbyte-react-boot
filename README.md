# Running React in Spring boot App
In the realm of software development, breaking down applications into multiple deployment units is often advocated for enhanced agility. Yet, there are instances where the need arises to deploy an application as a single cohesive package. This could be driven by factors like cost-effectiveness or swift proof of concept validation.

In this article, we will meticulously guide you through the process of developing separate frontend and backend applications and ingeniously merging them into a singular, deployable entity. Our chosen technologies for this seamless integration are React for the frontend and Spring Boot for the backend.

## Prerequisites
- Fundamental familiarity with spring boot app creation
- Basic hands-on experience in react app development
- Understanding of Gradle
- Java 17 installed

Let's embark on this journey to create disparate frontend and backend components, harmoniously united under the banner of a single deployable unit.

1. **Project Setup:**
   Start by creating a designated directory named 'react-in-boot' to house our integrated project.
   
2. **Frontend Creation:**
   Within the 'react-in-boot' directory, create a foundational React app named 'react-front'.
   
3. **Frontend Compilation:**
   Execute the command `npm run build` within the 'react-front' directory. This will generate a 'build' folder, which holds the compiled React app.

4. **Backend Creation:**
   Set up the backend of our application by creating a basic Spring Boot project using Gradle as the build tool.

5. **Gradle Configuration:**
   Within your backend project's `build.gradle`, include the following task snippet:

   ```groovy
   task copyFrontendBuild(type: Copy) {
       from '../react-front/build'  
       into 'build/resources/main/static'
   }
   processResources.dependsOn(copyFrontendBuild)
   ```

   This task is designed to copy the content from the 'build' folder of your React app into the appropriate directory of your Spring Boot project.

6. **Backend compilation and server start:**
   Excecute command `gradlew clean build` to compile and build the backend project. After that Execute command `gradlew bootRun` to start the backend spring boot app.

7. **Integration in Action:**
   Now, execute command `gradlew bootRun` to start Spring Boot application. Visit [http://localhost:8080](http://localhost:8080) in your browser and verify that react home page is displayed.
 

## In Conclusion

The convergence of a React frontend and Spring Boot backend into a singular deployable unit is a testament to the versatility of modern software development. While advocating the deconstruction of applications for agility remains crucial, the ability to consolidate them for specific use cases underscores the adaptability of developers in a dynamic landscape.
