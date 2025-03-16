/**
 * The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
 * It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
 *
 * This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
 * a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
 * records, and manage data volume using the LIMIT keyword.
 *
 * Topics covered in this class include:
 * - Understanding the structure of a SOQL query.
 * - Crafting basic SELECT statements in SOQL.
 * - Applying filters using the WHERE clause in SOQL.
 * - Fetching related records using Relationship queries.
 * - Controlling the amount of data retrieved using the LIMIT keyword.
 *
 * Users of this class can expect to gain a solid understanding of SOQL in Apex and
 * be prepared to handle data retrieval tasks in Salesforce development.
 *
 * @author Mackenzie
 */

public with sharing class SOQL {
	/**
	 * Question 1
	 * Update/Uncomment the template code to create a method
	 * Returns all leads from Salesforce Org
	 * @return List of all leads with Id, LastName, Company, Phone, Email
	 * Update the corresponding test class and testGetAllLeads method to cover this method
	 */
	public static List <Lead> allLeads() {
	List <Lead> everySingleLead = 
	[SELECT id, LastName, Company, Phone, Email
	FROM lead 
	WITH user_mode
	];
	return everySingleLead;
	}

	/**
	 * Question 2
	 * Update/Uncomment the template code to create a method
	 * Returns all contacts with first name of John.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByFirstName method to cover this method
	 */
	public static List <Contact> dearJohns () {
		List <Contact> johnnys  = 
		[SELECT id, FirstName, Name FROM contact WHERE firstName = 'John' WITH user_mode];
	return johnnys;
	}

	/**
	 * Question 3
	 * Update/Uncomment the template code to create a method
	 * Returns the Contact Id for all contacts with last name of Smith or Jones
	 * @return A list of Contact Ids.
	 * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
	 */
	public static List <ID> getGenericAmericans () {
	List <ID> genericAmericanIds = new List <ID>();
	List <Contact> maybeMidwesterners = 
	[SELECT id 
	FROM contact 
	WHERE lastName in ('Smith', 'Jones')
	WITH user_mode]; 
	for (Contact midwesterner : maybeMidwesterners){
		genericAmericanIds.add(Midwesterner.Id);
		}
	return genericAmericanIds;
	}

	/**
	 * Question 4
	 * Update/Uncomment the template code to create a method
	 * Returns List of closed won opportunities for a specific Account.
	 * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Opportunities with important opportunities fields
	 * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
	 */
	public static List <Opportunity> closedWonOpportunities (Account moneyMaker) {
		List <Opportunity> moneyMade = 
		[SELECT id, Name, closeDate, stageName, accountId, amount
		FROM Opportunity 
		WHERE accountId = :moneyMaker.id
		AND stageName = 'Closed Won'
		WITH user_mode];
		return moneyMade;
	}

	/**
	 * Question 5
	 * Update/Uncomment the template code to create a method
	 * Returns the total count of Account records.
	 * @return The Integer count of Account records.
	 * Update the corresponding test class and testGetAccountCount method to cover this method
	 */
	public static Integer gotAccounts() {
	List <AggregateResult> accountsTotal = [SELECT count(id) accountCount FROM account WITH user_mode];
	Integer gotEm = (Integer)accountsTotal[0].get('accountCount');
	return gotEm;
	}

	/**
	 * Question 6
	 * Update/Uncomment the template code to create a method
	 * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
	 * @return A map of Task Ids to Task records.
	 * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
	 */
	public static map <id, Task> getMyToDoList() {
	Map<Id, Task> toDoList = new Map <Id, Task>([SELECT id FROM task WHERE activityDate <= next_N_Days:7]);
	return toDoList;
	}

	/**
	 * Question 7
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Contacts that have a example.com domain in their Email.
	 * @return A list of Contact records.
	 * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
	 */
	public static List <Contact> getContactsByDomain (String domain) {
		String formattedDomain = '%'+ domain;
	List <Contact> marks = [SELECT id, Name, Email FROM contact WHERE email Like :formattedDomain WITH user_mode];
	return marks;
	}

	/**
	 * Question 8
	 * Retrieves all Opportunities that have a specific keyword in their Name.
	 * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
	 * @param keyword The keyword to search for in the Opportunity Name.
	 * @return A list of Opportunity records.
	 */
	public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
		String keywordFormatted = '%'+keyword+'%';
		List <Opportunity> opportunities = [SELECT id, Name FROM Opportunity WHERE name LIKE :keywordFormatted WITH user_mode];
		return opportunities; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 9
	 * Retrieves all Cases that Case Origin is not Web or Email or Blank
	 * @return A list of Case records.
	 */
	public static List<Case> getFilterCaseOrigins() {
		List <Case> cases = [SELECT id, origin FROM case WHERE origin NOT IN ('Web', 'Email', null) WITH user_mode];
		return cases; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 10
	 * Update/Uncomment the template code to create a method
	 * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
	 * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
	 * @param leadSource The Lead Source to search for.
	 * @param keyword The keyword to search for in the Lead Title.
	 * @return A list of Lead records.
	 * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
	 */
	public static List <Lead> getLeadsCreatedBy (String leadSource, String title) {
	String formattedTitle = '%'+title+'%';
	String formattedSource = '%'+leadSource+'%';
		List <Lead> leads = 
		[SELECT id, leadSource, title, lastName, company, phone, email
		FROM lead
		WHERE title LIKE :formattedTitle
		OR leadSource LIKE :formattedSource
		WITH user_mode];
	return leads;
	}

	/**
	 * Question 11
	 * Returns the names of all Contacts associated with an Account.
	 * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A list of Contact LastName.
	 */
	public static List<String> getContactNamesByAccount(Id accountId) {
		List <String> lastNamesByAccount = new List <String>();
		List <Contact> contacts = 
		[SELECT LastName 
		FROM Contact 
		WHERE accountId = :accountId
		WITH user_mode];

		for (Contact cont : contacts){
			lastNamesByAccount.add(cont.lastName);
		}
		// Create a list to hold the Contact LastNames

		// Query the Contacts
		// Loop through each Contact and add the LastName to the list
		//for () {
		//
		//}

		// Return the list of Contact LastNames
		return lastNamesByAccount; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 12
	 * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
	 * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for the found opportunities
	 * @param stage The Stage value to filter Opportunities.
	 * @return The total revenue.
	 */
	public static Decimal getTotalRevenueByStage(String stage) {
		AggregateResult aggregateSumByStage = 
		[SELECT sum(amount) revenue
		FROM Opportunity
		WHERE stageName = :stage 
		OR amount > 10000
		WITH user_mode];
		Decimal sumByStage = (Decimal)aggregateSumByStage.get('revenue');
		return sumByStage;
	}

	/**
	 * Question 13
	 * Retrieves the first 10 Accounts ordered by Name.
	 * @return A list of the first 10 Accounts ordered by Name.
	 */
	public static List<Account> getFirstTenAccounts() {
		List <Account> tenAccounts = [SELECT Id, Name
									FROM Account
									WITH user_mode
									ORDER BY Name
									LIMIT 10];
		return tenAccounts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 14
	 * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
	 */
	public static List<Opportunity> getHighValueOpportunities() {
		List<Opportunity> highValueMarks = [SELECT id, amount, closeDate
											FROM Opportunity
											WHERE amount > 100000
											WITH user_mode
											ORDER BY closeDate
											LIMIT 5];
		return highValueMarks; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 15
	 * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
	 * @return A list of Contacts
	 */
	public static List<Contact> getBirthdateContacts() {
		Date today = Date.today();
		List<Contact> recentBirthdays = [SELECT id, birthdate
											FROM Contact
											WHERE birthdate < :today
											WITH user_mode
											ORDER BY birthdate desc
											LIMIT 3];
											//need to order by today-birthday?
		return recentBirthdays; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 16
	 * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
	 * @return A list of Cases
	 */
	public static List<Case> getCasesWithStatus() {
		List<Case> openCases = [SELECT id, CreatedDate
								FROM Case
								WHERE Status = 'Open'
								WITH user_mode
								ORDER BY createdDate
								LIMIT 10
								OFFSET 5];
		return openCases; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 17
	 * Returns Set of Case Ids for a specific Account.
	 * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
	 * @param accountId The ID of the Account.
	 * @return A set of Case Ids.
	 */
	public static Set<Id> getCaseIdsByAccount(Id accountId) {
		Set<ID> caseIdByAccount = new Set<ID>();
		List<Case> caseByAccount = [SELECT Id
									FROM Case
									WHERE accountId = :accountId
									WITH user_mode];
		for (case relatedCase : caseByAccount){
			caseIdByAccount.add(relatedCase.id);
		}
		// Create a set to hold the Case Ids

		// Query the Cases
		// Loop through each Case and add the Id to the set
		//for () {
		//
		//}

		return caseIdByAccount; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 18
	 * Return Map of Account Ids to Account Names Not in a specific Country.
	 * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
	 * @param country The country to filter Accounts.
	 * @return A map of Account Ids to Account Names.
	 */
	public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
		// Create a map to hold the Account Ids to Account Names
		Map<Id, String> accountIdsToNames = new Map<Id, String>();
		List<Account> accountsNotInCountry = [SELECT Id, Name
												FROM Account
												WHERE BillingCountry != :country
												WITH user_mode];
		for (account acc : accountsNotInCountry){
			accountIdsToNames.put(acc.id, acc.Name);
		}
		// Query the Accounts
		// Loop through each Account and add the Id and Name to the map

		return accountIdsToNames; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 19
	 * Retrieves the Account Name for a given Contact.
	 * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
	 * @param contactId The Id of the Contact.
	 * @return The Account Name of the Contact.
	 */
	public static String getAccountNameForContact(String contactId) {
		Contact con = [SELECT Id, Account.Name 
		FROM Contact
		WHERE Id = :contactId
		WITH user_mode];
		return con.Account.Name; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 20
	 * Returns single Account that has related opportunities in the same query
	 * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
	 * @param accountId The ID of the Account.
	 * @return An Account record with related Opportunities.
	 */
	public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
		Account accountWithOpportunities = [SELECT Id, Name, (SELECT Id, Name
																		FROM Opportunities
																		WHERE accountid = :accountId)
		FROM account
		WHERE id = :accountId
		WITH user_mode];
		return accountWithOpportunities; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 21
	 * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
	 * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
	 * @param Account Id
	 * @return List of contacts with the same Mailing State as the Account Billing State
	 */
	public static List<Contact> getAccountsWithContactsByState(Id accountId) {
		Account startingAcc = [SELECT id, billingState
								FROM Account
								WHERE id = :accountId
								WITH user_mode
								];
		String searchableState = startingAcc.billingState;
		List <Contact> foundContacts = [SELECT Id, MailingState
										FROM Contact
										WHERE MailingState = :searchableState
										WITH user_mode];
		// Query the Account

		// Store the Account's BillingState

		// Query the Contacts
		return foundContacts; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 22
	 * Extracts email domains from them leads, then finds Accounts with matching website domains
	 * If Lead Email = test@test.com return account with website = www.test.com
	 * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
	 * @param A set of Lead Ids.
	 * @return A list of Accounts with matching email domains.
	 */
	public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
		List <Lead> leadsByDomain = [SELECT id, email
									FROM lead
									WHERE id = :leadIds];
		Set <String> domains = new Set <String>();
		for (Lead leadWDomain : leadsByDomain){
			if (leadWDomain.email == null || leadWDomain.email.contains('@') == false){
				continue;
			}
			String strippedEmail = leadWdomain.email;
			String domain = strippedEmail.substring((strippedEmail.indexOf('@'))+1);
			domain = '%' + domain;
			domains.add(domain);
		}
		List <Account> accountsForDomain = 
			[SELECT id, website
			FROM Account
			WHERE website like :domains
			WITH user_mode];

		// Query the Leads

		// Create a set of email domains from the Leads

		// Loop through each Lead

		// Get the email from the Lead

		// Check if the email is not null

		// Add the email domain to the set

		// Query the Accounts
		return accountsForDomain; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 23
	 * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
	 * Adds a randomized number between 1 to 3 to the quantity of each line item.
	 * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
	 * @param Original Opportunity Id
	 * @param List of cloned Opportunity Ids
	 */
	public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
		List<OpportunityLineItem> originalLineItems = [SELECT id, quantity, opportunityId, unitPrice, PricebookEntryId
														FROM OpportunityLineItem
														WHERE OpportunityId = :origOppId
														WITH user_mode];
		// Query the original Opportunity Line Items
			
		// Create a list to hold the new line items
		List <OpportunityLineItem> newLineItems = new List <OpportunityLineItem>();
		// Generate a random number between 1 and 3 
		Integer randomNumber = Integer.valueOf(Math.Random()*10);
		do{randomNumber = Integer.valueOf(Math.Random()*10);
		}
			while (randomNumber < 1 || randomNumber > 3 );


		// Loop through each cloned Opportunity Id
		//List <Opportunity> clonedOpp = [SELECT id
		//								FROM Opportunity
		//								WHERE id = :cloneOppIds];

		// Loop through each original line item
		for(OpportunityLineItem oli : originalLineItems){
			OpportunityLineItem clonedOli = oli.clone();
			clonedOli.quantity = clonedOli.quantity + randomNumber;
			newLineItems.add(clonedOli);
		}

		// Clone the original line item and add the random number to the quantity

		// Insert the new line items
			
	List<OpportunityLineItem> clonesForInsert = new List<OpportunityLineItem>();

	for(ID id : cloneOppIds){
		for(OpportunityLineItem lineItem : newLineItems){
			lineItem.opportunityId = id;
			clonesForInsert.add(lineItem);
		}
	}
	Insert newLineItems;
	}

	/**
	 * Question 24
	 * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
	 * @return A list of filtered Opportunity
	 */
	public static List<Opportunity> getOpportunityDetailsForClosedWon() {
		List <Opportunity> closedWonOpps = [SELECT Id, Name, account.name, accountid, owner.name
											FROM Opportunity
											WHERE stageName = 'Closed Won'
											WITH user_mode];

		return closedWonOpps; // Replace null with the variable you used to store the result
	}

	/**
	 * Question 25
	 * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to the Contact on the associated Account with the alphabetically first first name.
	 * Example: if there are two Contacts on the Account, "Billy" and "Abby," the 'Primary_Contact__c' will be set to "Abby."
	 */
	public static void setPrimaryContact() {
		//Use the getOpportunityDetailsForClosedWon() method to get the Opportunities
		List <Opportunity> closedWonOpps = getOpportunityDetailsForClosedWon();

		// Create a set of Account Ids from the Opportunities
		Set <ID> closedWonAccs = new Set <ID>();
		for(Opportunity opp : closedWonOpps){
			closedWonAccs.add(opp.accountId);
		}

		// Query the Contacts
		List <Contact> allRelatedContacts = [SELECT id, FirstName, accountId
												FROM Contact
												WHERE accountId IN :closedWonAccs
												WITH user_mode
												ORDER BY FirstName];

		//HOW DO I GET ONE CONTACT FOR ONE ACCOUNT ID?! god this was rough
		Map <Id, Contact> AccContactMap = new Map <Id, Contact>();
		for (Contact con : allRelatedContacts){
			if(accContactMap.ContainsKey(con.accountId) == false){
				AccContactMap.put(con.accountId, con);
			}
		}

		// Loop through each Opportunity
		for (Opportunity oppToUpdate : closedWonOpps){
			oppToUpdate.Primary_contact__c = AccContactMap.get(oppToUpdate.AccountId).id;
		}

		// Update the Opportunities

		Upsert closedWonOpps;
	}
}
