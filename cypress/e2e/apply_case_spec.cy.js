describe('Cypress Apply Script', () => {

	it('Make a case in Apply to use in CCMS', () => {

		// Get username, password and URL from environment varisables
		// Can set in cypress.env.json (in top dir) or supply/over-ride 
		// using --env option from command-line 
		const username = Cypress.env('APPLY_USERNAME');
		const password = Cypress.env('APPLY_PASSWORD');
		const apply_url = Cypress.env('APPLY_URL');

		cy.visit(apply_url);
		
		// "Start Now" button on the homepage
		cy.get('#start').click()
		
		// Login (direct, not portal)
		cy.get('#email').type(username);
		cy.get('#password').type(password);
		cy.get('input[type=submit]').click();
		// below fails in UAT (not needed as portal thing?)
		/// cy.get('a').contains('Apply for Legal Aid').invoke('removeAttr', 'target').click();
		
		// Office Account No - different behaviour when only one choice 
		if (cy.get('h1').contains("your office account number?")){
			cy.get('#binary-choice-form-confirm-office-true-field').click();
		}
		else {
			cy.get('.gov-ukradios > div:nth-child(1) > input').click();
		}	
		cy.get('#continue').click();
		
		//Applications
		cy.get('#start').click();
		
		//Declaration
		cy.get('#continue').click();
		
		//Client Details
		cy.get('#applicant-first-name-field').type('CCMSTest');
		cy.get('#applicant-last-name-field').type('Walker');
		cy.get('#applicant_date_of_birth_3i').type('10');
		cy.get('#applicant_date_of_birth_2i').type('1');
		cy.get('#applicant_date_of_birth_1i').type('1980');
		cy.get('#applicant-national-insurance-number-field').type('JA293483A');
		cy.get('#continue').click();
		
		//Correspondence Address
		cy.get('a').contains('Enter address manually').click();
		cy.get('#address-address-line-one-field').type('123 Test Street');
		cy.get('#address-city-field').type('Test City');
		cy.get('#address-county-field').type('Test');
		cy.get('#address-postcode-field').type('TE15 1NG');
		cy.get('#continue').click();	
		
		//What is legal aid for
		cy.get('#proceeding-search-input').type('Domestic Abuse');
		// Below fails in UAT
		///cy.get('.govuk-label govuk-radios__label').contains('Non-molestation order').parents('.govuk-radios__item').eq(0).within(() => {
		///	cy.get('input').click()
		///})
		// Alternative quick bodge
		cy.wait(1000);
		cy.get('#id-da004-field').click()
		cy.get('#continue').click();

		//Add Another Proceeding?
		// Below fails in UAT
		///cy.get('.gov-ukradios > div:nth-child(2) > input').click();
		// Alternative - this one is "No" button
		cy.get('#legal-aid-application-has-other-proceeding-field').click()
		cy.get('#continue').click();

		//Delegated Functions?
		cy.get('input[id=legal-aid-applications-used-multiple-delegated-functions-form-none-selected-true-field]').click();
		cy.get('#continue').click();
		//What you're applying for
		cy.get('#continue').click();
		//Check your answers
		cy.get('#continue').click();
		//Passported Benefit
		cy.get('#continue').click();
		//What you need to do
		cy.get('#continue').click();
		//Does your client own the home they live in?
		cy.get('input[id=legal-aid-application-own-home-no-field]').click();
		cy.get('#continue').click();
		//Does your client own a vehicle?
		cy.get('input[id=legal-aid-application-own-vehicle-field]').click();
		cy.get('#continue').click();
		
		//Bank Account
		cy.get('input[id=savings-amount-check-box-offline-current-accounts-true-field]').click();
		cy.get('#savings-amount-offline-current-accounts-field').type('100');
		cy.get('#continue').click();
		
		//Savings or Investments
		cy.get('input[id=savings-amount-none-selected-true-field]').click();
		cy.get('#continue').click();
		
		//Client Assets
		cy.get('input[id=other-assets-declaration-none-selected-true-field]').click();
		cy.get('#continue').click();	
		
		//Client Prohibited from selling?
		cy.get('input[id=legal-aid-application-has-restrictions-field]').click();
		cy.get('#continue').click();
		
		//Charity Payments
		cy.get('input[id=policy-disregards-none-selected-true-field]').click();
		cy.get('#continue').click();
		//Check your answers
		cy.get('#continue').click();
		
		//Client Eligibility
		cy.get('#continue').click();
		
		//Detail of case
		cy.get('a').contains('Latest incident details').click();
		cy.get('#application_merits_task_incident_told_on_3i').type('1');
		cy.get('#application_merits_task_incident_told_on_2i').type('1');
		cy.get('#application_merits_task_incident_told_on_1i').type('2022');
		cy.get('#application_merits_task_incident_occurred_on_3i').type('1');
		cy.get('#application_merits_task_incident_occurred_on_2i').type('12');
		cy.get('#application_merits_task_incident_occurred_on_1i').type('2021');
		cy.get('#continue').click();
		
		//Opponent Details
		cy.get('#application-merits-task-opponent-full-name-field').type('Test Opponent');
		cy.get('input[id=application-merits-task-opponent-understands-terms-of-court-order-true-field]').click();
		cy.get('input[id=application-merits-task-opponent-warning-letter-sent-true-field]').click();
		cy.get('input[id=application-merits-task-opponent-police-notified-true-field]').click();
		cy.get('#application-merits-task-opponent-police-notified-details-true-field').type('Test');
		cy.get('input[id=application-merits-task-opponent-bail-conditions-set-field]').click();
		cy.get('#continue').click();
		
		//Statement of Case
		cy.get('#application-merits-task-statement-of-case-statement-field').type('Statement Test');
		cy.get('#continue').click();
		
		//Chances of success
		cy.get('a').contains('Chances of success').click();
		
		//Outcomes 50% or better?
		cy.get('input[id=proceeding-merits-task-chances-of-success-success-likely-true-field]').click();
		cy.get('#continue').click();
		cy.get('#continue').click();
		
		//Check your answers
		cy.get('#continue').click();
		
		//Confirm the following
		cy.get('input[id=legal-aid-application-client-declaration-confirmed-true-field]').click();	
		cy.get('#continue').click();
		
		//Review your application - This currently saves and comes back later
		///cy.get('#draft_button').click();

		//Below will submit the application but the #draft_button line above needs to be 
		// commented out for this to work.
		cy.get('#continue').click();
		cy.get('h1').contains('Application complete');

		// Go on to "View completed application"
		cy.get('#continue').click();
		cy.get('h1').contains('Application for civil legal');
		// The client name, LAA reference and CCMS reference are in a dl (description list) that's identified by class name
		cy.get('.govuk-list');

		// Way of extracting reference numbers from the <dl> list on View Completed Application
		// Likely can be improved!
		const description_list_item1 = cy.get('dl dd').eq(1);
		description_list_item1.then(($el) => {
		  const text = $el.text();
		  cy.log("LAA Reference");
		  cy.log(text);
		  // Below depends on 'log' task defined in cypress.config.js
		  // Unlike cy.log, it writes to the actual terminal
		  cy.task('log', 'LAA Reference');
		  cy.task('log', text);
		});
		const description_list_item2 = cy.get('dl dd').eq(2);
		description_list_item2.then(($el) => {
		  const text = $el.text();
		  cy.log("CCMS Reference");
		  cy.log(text);
		  // Below depends on 'log' task defined in cypress.config.js
		  // Unlike cy.log, it writes to the actual terminal
		  cy.task('log', 'CCMS Reference');
		  cy.task('log', text);
		});

	})
})