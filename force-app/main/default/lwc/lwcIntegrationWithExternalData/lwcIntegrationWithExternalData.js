import { LightningElement, wire } from 'lwc';
import getAccountDetails from '@salesforce/apex/ExternalDataCallout.getAccountDetails';

export default class LwcIntegrationWithExternalData extends LightningElement {
    parsedData;
    buttonClick() { 
        getAccountDetails()
        .then((response) => {
            console.log("###Response : " + response);
            this.parsedData = response;
        })
            .catch((error) => {
                this.condition = 'No matching location found.';
                console.log('###Error : ' + JSON.stringify(error));
            });
    }
}