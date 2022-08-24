import {api, LightningElement, wire, track} from 'lwc';
import getDiaryNotesByContactId from '@salesforce/apex/DiaryController.getDiaryNotesByContactId';
import createNewDiaryRelated from '@salesforce/apex/DiaryController.createNewDiaryRelated';
import {deleteRecord} from 'lightning/uiRecordApi';
import {refreshApex} from '@salesforce/apex';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';

export default class RelatedDiaryNotes extends LightningElement {

    @api recordId;

    @wire(getDiaryNotesByContactId, {contactId: '$recordId'})
    diaryNotes;

    @track error;

    handleAddNote(event) {
        this.note = event.target.value;
    }

    createDiaryNotes() {
        createNewDiaryRelated({contactId: this.recordId, note: this.note})
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record saved',
                        variant: 'success'
                    })
                );
                this.template.querySelector('lightning-input').value = null;  // clear input field
                eval("$A.get('e.force:refreshView').fire();");                     // refresh related list
                return refreshApex(this.diaryNotes);                                  // refresh component
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            })
    }

    deleteRecords(event) {
        const recordId = event.target.dataset.record;
        deleteRecord(recordId)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
                return refreshApex(this.diaryNotes);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
    }
}