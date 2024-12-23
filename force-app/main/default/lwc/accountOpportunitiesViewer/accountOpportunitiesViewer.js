import { LightningElement, api, wire, track } from 'lwc';
import getOpportunities from '@salesforce/apex/AccountOpportunitiesController.getOpportunities';
import { refreshApex } from '@salesforce/apex';

export default class AccountOpportunitiesViewer extends LightningElement {
    @api recordId;
    @track opportunities;
    @track wiredOpp;
    @track error;
    columns = [
        { label: 'Nom Opportunité', fieldName: 'Name', type: 'text' },
        { label: 'Montant', fieldName: 'Amount', type: 'currency' },
        { label: 'Date de Clôture', fieldName: 'CloseDate', type: 'date' },
        { label: 'Phase', fieldName: 'StageName', type: 'text' }
    ];
    @wire(getOpportunities, { accountId: '$recordId' }) 
    wiredOpportunities(result) {
        this.wiredOpp=result;
        if (result.data) {
            this.opportunities = result.data;
            this.error = null;
        } else if (result.error) {
            this.opportunities = [];
            this.error = error;
            console.error('Error loading opportunities:', error);
        }
    }
    // Refresh logic for "Rafraîchir" button
    async handleRafraichir() {    
        try {            
            await refreshApex(this.wiredOpp);
            console.log(this.wiredOpp);
        }
        catch (e)
        {
            console.error('handleRafraichir loading opportunities:',e);
        }
    }
}