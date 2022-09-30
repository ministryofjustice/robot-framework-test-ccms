describe('Cypress Check', () => {
    it('Does not do much!', () => {
      expect(true).to.equal(true)
      cy.log('Done!')
      cy.exec('echo moo')
      // Below depends on 'log' task defined in cypress.config.js
      // It send text to the actual terminal (unlike cy.log)
      cy.task('log', 'will we see this?')
    })
  })