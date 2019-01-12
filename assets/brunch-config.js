exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js"
    },

    stylesheets: {
      joinTo: "css/app.css",
      order: {
        after: ["web/static/css/app.scss"] // concat app.css last
      }
    },

    templates: {
      joinTo: "js/app.js"
    }
  },
  conventions: {
    assets: /^(web\/static\/assets)/
  },

  // Phoenix paths configuration
  paths: {

    // Dependencies and current project directories to watch
    watched: [
      "web/static",
      "test/static"
    ],

    // Where to compile files to
    public: "priv/static"
  },

  plugins: {
    copycat: {},

    babel: {
      ignore: [/web\/static\/vendor/]
    },

    sass: {
      mode: "native",
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["web/static/js/app"]
    }
  },

  npm: {
    globals: {
      $: "jquery",
      jQuery: "jquery"
    }
  },
  notifications: false
}
