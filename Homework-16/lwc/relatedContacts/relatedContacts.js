import {LightningElement, api, wire} from 'lwc';
import getContactsByAccountId from '@salesforce/apex/ContactController.getContactsByAccountId';
import addContact from '@salesforce/apex/ContactController.createNewContactRelated';
import { refreshApex } from '@salesforce/apex';

export default class RelatedContacts extends LightningElement {
    @api recordId;
    showForm = false;
    lastName;

    @wire(getContactsByAccountId, {accountId: '$recordId'})
    contacts;

    addContact() {
        this.showForm = !this.showForm;
    }

    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }

    createContact() {
        addContact({accountId: this.recordId, lastName: this.lastName})
            .then(() => {
                refreshApex(this.contacts).then(result => console.log('Contact Created'));
            })
            .catch(error => console.log(error))
    }
}