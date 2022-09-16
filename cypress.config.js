const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    supportFile: false,
    video: false,
    setupNodeEvents(on, config) {
      // implement node event listeners here
    },
  },
});
