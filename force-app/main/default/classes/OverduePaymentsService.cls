public class OverduePaymentsService {
    
    // Method to retrieve overdue payments for a single account
    public static list<Payment__c> getOverduePaymentsForAccount(List<Id> accountIds) {
        list<Payment__c> overdueAccount = new list<Payment__c> ();
        // Get today's date for comparison
        Date today = Date.today();
        // Query to fetch the account and its overdue payments
        if(accountIds.size()>0){
            overdueAccount = [ SELECT Account__c,Amount__c, Due_Date__c, Status__c FROM Payment__c  WHERE Account__c IN :accountIds];
            
        }else{
            overdueAccount = [ SELECT Account__c,Amount__c, Due_Date__c, Status__c FROM Payment__c  WHERE Status__c != 'Paid'];
        }
        // Check if there are any overdue payments for this account
        if (overdueAccount == null || overdueAccount.isEmpty()) {
            System.debug('No overdue payments found for this account.');
            return null;
        }
        
        // Return the account with its overdue payments
        return overdueAccount;
    }
    
    // Helper method to format overdue payment information for a single account
    @InvocableMethod(label='Get Overdue Payment Details' description='Returns the Payment status of the specified account IDs.' category='Account')
    public static list<String> getOverduePaymentDetails(List<Id> accountIds) {
        String overdueDetails ='';
        list<string> overdueList = new list<string>();
        list<Payment__c> pendingPayments = getOverduePaymentsForAccount(accountIds);
        // Loop through the related payments and get details of overdue payments
        for (Payment__c payment : pendingPayments) {
            if (payment.Due_Date__c < Date.today() && payment.Status__c != 'Paid') {
                overdueDetails += 'Payment of ' + payment.Amount__c + ' due on ' + payment.Due_Date__c + ', Status: ' + payment.Status__c + '\n';
            }
        }
        
        
        // If no overdue payments, return a default message
        overdueDetails = String.isBlank(overdueDetails) ? 'No overdue payments for this account.' : overdueDetails;
        overdueList.add(overdueDetails);
        return overdueList;
        
    }
}