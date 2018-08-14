// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
window.addEventListener("turbolinks:load", function() {
  const addRespondentSection = (() => {
    let addRespondentActions = document.querySelector('#add-respondent');
    let createButton = document.querySelector('#add-respondent__create-button');
    let searchButton = document.querySelector('#add-respondent__search-button');

    createButton.onclick = () => {
      let createRespondentForm = document.querySelector('#add-respondent__create-form');
      let cancelCreateButton = document.querySelector('#add-respondent__create-form-cancel');

       toggleDisplay(addRespondentActions, createRespondentForm);

      cancelCreateButton.onclick = () => {
        let respondentFirstName = document.querySelector('#respondent_firstname');
        let respondentLastName = document.querySelector('#respondent_lastname');

        toggleDisplay(addRespondentActions, createRespondentForm);

        clearFieldAndLabel(respondentFirstName);
        clearFieldAndLabel(respondentLastName);
      }
    }

    searchButton.onclick = () => {
      let searchRespondentForm = document.querySelector('#add-respondent__search-form');
      let cancelSearchButton = document.querySelector('#add-respondent__search-form-cancel');

      toggleDisplay(addRespondentActions, searchRespondentForm);

      cancelSearchButton.onclick = () => {
        toggleDisplay(addRespondentActions, searchRespondentForm);
        clearRespondentSelect();
      }
    }

    const clearFieldAndLabel = (field) => {
      field.value = '';
      field.previousElementSibling.classList.remove('active');
    }

    const clearRespondentSelect = () => {
      let dropDown = document.querySelector('#add-respondent__dropdown');

      dropDown.selectedIndex = 0;
    }

    const toggleDisplay = (...elems) => {
      elems.forEach(function(elem) {
        if (getComputedStyle(elem, null).display === 'none') {
          elem.style.display = 'block';
        } else {
          elem.style.display = 'none';
        }
      })
    }
  })()

  const initializeAutoComplete = (() => {
    
  })
}, false);