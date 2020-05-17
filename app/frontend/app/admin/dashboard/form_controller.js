import { Controller } from 'stimulus'
import flatpickr from 'flatpickr'
require('flatpickr/dist/flatpickr.css');

export default class FormController extends Controller {
    static targets = ['form'];

    connect() {
        flatpickr("[data-behaviour='flatpickr']", {
            altInput: true,
            altFormat: "F j, Y H:i",
            dateFormat: "Y-m-d H:i",
            enableTime: true,
            time_24hr: true
        });
    }

    submitForm(e) {
        let isValid = this._validateForm(this.formTarget);

        // If our form is invalid, prevent default on the event
        if (!isValid) e.preventDefault();
    }

    _validateForm() {
        let isValid = true;

        let requiredFieldSelectors = 'input:required';
        let requiredFields = this.formTarget.querySelectorAll(requiredFieldSelectors);

        requiredFields.forEach((field) => {
            if (!field.disabled && !field.value.trim()) {
                field.focus();
                field.nextElementSibling.textContent = "Can't be blank!";

                isValid = false;
            }
        });

        if (!isValid) {
            return false;
        }

        let invalidFields = this.formTarget.querySelectorAll('input:invalid');

        invalidFields.forEach((field) => {
            if (!field.disabled) {
                field.focus();
                field.nextElementSibling.textContent = "Format should be: XX.XX";
                isValid = false;
            }
        });

        return isValid;
    }
}