const { defineConfig } = require("cypress");

module.exports = defineConfig({
  e2e: {
    supportFile: false,
    video: false,
    // Below intended to enable posting of text to the real terminal (not cypress internal thing)
    setupNodeEvents(on, config) {
      on('task', {
        log(message) {
          console.log(message)
          return null
        },
      })
      
    },
  },
});
