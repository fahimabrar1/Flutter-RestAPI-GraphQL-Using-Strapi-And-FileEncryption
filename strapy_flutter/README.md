# strapy_flutter

#   Below are the commands for strapi, install anywhere in your workplace.

- npx create-strapi-app@latest strapi


#   Override Strapi Package.json:
- "overrides": {
       "@strapi/plugin-graphql": {
          "graphql": "15.8.0"
        }
     }


#   Install GraphQl:
- npm install @strapi/plugin-graphql

#   Run strapi server
- npm run develop


#   If encounter error for duplicate graphql module
#   Remove GraphQl:
-   npm remove @strapi/plugin-graphql


#   Delete the graphql folder from "Directory\strapi\node_modules",
#   Then reinstall the plugin and try to run
