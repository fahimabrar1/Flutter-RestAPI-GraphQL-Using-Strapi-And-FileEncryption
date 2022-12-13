# 
<div align="center">
  <h1>Flutter-RestAPI-GraphQL-Using-Strapi-And-FileEncryption</h1>
  
  <p>
A demo app which can fetch data from strapi RESTAPI and GraphQL. Download file from strapi and also encrypt and decrypt the file using your app.
  </p>

</div>

<!-- GETTING STARTED -->
## :toolbox: Getting Started
Strapi graphql plugin has issues itself. Following steps helps to resolve the issue. And properly fetches data using graphql from your app. By running strapi local server on our machine.

* Install strapi anywhere in your workplace.
  ```sh
   npx create-strapi-app@latest strapi
  ```

* Override Strapi Package.json:
  ```sh
  "overrides": {
         "@strapi/plugin-graphql": {
            "graphql": "15.8.0"
         }
     }
  ```

* Install GraphQl:
  ```sh
  npm install @strapi/plugin-graphql
  ```
  
* Run strapi server:
  ```sh 
  npm run develop
  ```

`If encounter error for duplicate graphql module`
* Remove GraphQl:
  ```sh 
  npm remove @strapi/plugin-graphql
  ```

`Delete the graphql folder from "Directory\strapi\node_modules"`

`Then reinstall the plugin and try to run`

