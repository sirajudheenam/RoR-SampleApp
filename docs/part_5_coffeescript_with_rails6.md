# Part 5 - CoffeeScript with Rails 6

```
rails webpacker:install:coffee

```

Make sure you have package.json like this: pay attention to `coffee-loader` version.

```json
{
  "name": "sample-app",
  "private": true,
  "dependencies": {
    "@rails/actioncable": "^6.0.0",
    "@rails/activestorage": "^6.0.0",
    "@rails/ujs": "^6.0.0",
    "@rails/webpacker": "5.3.0",
    "bootstrap": "^4.6.0",
    "coffee-loader": "^0.9.0",
    "coffeescript": "1.12.7",
    "jquery": "^3.6.0",
    "popper.js": "^1.16.1",
    "stimulus": "^2.0.0",
    "turbolinks": "^5.2.0",
    "webpack": "^4.46.0",
    "webpack-cli": "^3.3.12"
  },
  "version": "0.1.0",
  "devDependencies": {
    "@babel/core": "^7.14.0",
    "@babel/preset-env": "^7.14.0",
    "webpack-dev-server": "^3.11.2"
  }
}
```

# Verify if this is working :

Insert this line to your `application.html.erb` page in the <head> section

```
<%= javascript_pack_tag 'hello_coffee' %>
```
Once application is loaded, verify a message on the browser console.

`Hello world from coffeescript`

# Troubleshooting :

rm -rf node_modules package-lock.json yarn.lock
npm install --legacy-peer-deps


