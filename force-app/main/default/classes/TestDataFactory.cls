@IsTest
public class TestDataFactory {
    public static Account createTestAccount() {
        Account acc = new Account(Name='Test Account');
        insert acc;
        return acc;
    }

    public static Opportunity createTestOpportunity(Id accountId) {
        Opportunity opp = new Opportunity(
                Name='Test Opportunity',
                StageName='Prospecting',
                CloseDate=System.today().addDays(30),
                Amount=10000,
                AccountId=accountId
        );
        insert opp;
        return opp;
    }
    public static void createTestCases(Id accId) {
        Case case1 = new Case(
            AccountId = accId,
            Subject = 'Test Subject 1',
            Status = 'New',
            Priority = 'Medium'
        );
        Case case2 = new Case(
            AccountId = accId,
            Subject = 'Another Test Subject',
            Status = 'Closed',
            Priority = 'High'
        );
        insert new List<Case>{case1, case2};
    }
}