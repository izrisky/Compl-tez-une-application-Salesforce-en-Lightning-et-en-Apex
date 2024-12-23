public with sharing class AccountCasesController {

    @AuraEnabled(Cacheable=true)
    public static List<Case> findCasesBySubject(Id accountId, String subjectSearchTerm) {
        // Validation des paramètres pour éviter des requêtes inutiles
        if (accountId == null /*|| String.isBlank(subjectSearchTerm)*/) {// Dans le cas ou subjectSearchTerm est vide, on renvoie toutes les Cases de l'account, sinon on peut déclencer une exception
            throw new IllegalArgumentException('accountId et subjectSearchTerm doivent être renseignés.');
        }
    
        // Requête SOQL avec filtre sur AccountId et recherche dans le champ Subject
        return [
            SELECT Id, Subject, Status, Priority
            FROM Case
            WHERE AccountId = :accountId
            AND Subject LIKE :('%' + subjectSearchTerm + '%')
        ];
    }
}
