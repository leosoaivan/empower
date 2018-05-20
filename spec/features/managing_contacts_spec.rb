require 'rails_helper'

describe 'Contacts management -', type: :feature do
  let (:user) { create(:user_staff) }
  let (:client) { create(:client) }
  let! (:episode) { create(:episode, petitioner_id: client.id) }
  let! (:contact) { 
    create(
      :contact, 
      episode_id: episode.id, 
      user_id: user.id,
      body: 'This is a new contact.',
      services: [service1, service2]
    )
  }
  let! (:service_type) { create(:service_type, name: 'crisis') }
  let! (:service1) { create(:service, name: 'provided shelter', service_type: service_type) }
  let! (:service2) { create(:service, name: 'provided hotel', service_type: service_type) }
  
  let (:alert_danger) { '.flash__alert--danger' }
  let (:alert_success) { '.flash__alert--success' }

  before :each do
    log_in user
    visit client_path(client)
    click_on 'View episode'
  end
  
  describe 'creating a contact', js: true do
    before :each do
      click_on 'Create contact'
    end
    
    context 'with valid input' do
      before :each do
        fill_in 'Body', with: 'This is a contact body.'
        find('div#crisis', text: 'crisis').click
        check(service1.name, allow_label_click: true)
        click_on 'Create Contact'
      end
      
      it 'displays a successful message' do
        expect(page).to have_css alert_success
      end

      it 'redirects a user back to the episode' do
        expect(current_path).to eql episode_path(episode)
      end

      it 'displays the newly added contact' do
        expect(page).to have_content 'This is a contact body.'
      end

      it 'displays the selected services' do
        expect(page).to have_content service1.name
      end
    end

    context 'with an invalid input' do
      before :each do
        fill_in 'Body', with: ''
        click_on 'Create Contact'
      end

      it 'flashes a danger message' do
        expect(page).to have_css alert_danger
      end

      it 'returns the form' do
        expect(page).to have_css 'form'
      end
    end
  end

  describe 'editing a contact', js: true do
    before :each do
      click_on 'Edit contact'
    end
    
    context 'with a valid body' do
      before :each do
        fill_in 'Body', with: 'This is an edited contact.'
        find('div#crisis', text: 'crisis').click
        uncheck(service1.name, allow_label_click: true)
        click_on 'Edit Contact'
      end

      it 'displays a successful message' do
        expect(page).to have_css alert_success
      end

      it 'redirects a user back to the episode' do
        expect(current_path).to eql episode_path(episode)
      end

      it 'displays the edited body' do
        expect(page).to have_content 'This is an edited contact.'
      end

      it 'displays the edited services' do
        expect(page).not_to have_content service1.name
      end
    end

    context 'with an invalid body' do
      before :each do
        fill_in 'Body', with: ''
        click_on 'Edit Contact'
      end

      it 'displays a danger message' do
        expect(page).to have_css alert_danger
      end

      it 'returns the edit form' do
        expect(page).to have_css 'form'
      end
    end
  end

  describe 'deleting a contact', js: true do

    # Due to previous request being followed up with an AJAX request
    context 'with a flash already present' do
      before :each do
        click_on 'Create contact'
        fill_in 'Body', with: 'This is a contact body.'
        click_on 'Create Contact'

        within("tr#contact-#{contact.id}") do
          accept_confirm do
            click_on 'Delete contact'
          end
        end
      end

      it 'flashes only one message at a time' do
        expect(page).to have_selector('#flash', count: 1)
      end
    end

    context 'regardless of flash presence' do
      before :each do
        accept_confirm do
          click_on 'Delete contact'
        end
      end

      it 'flashes a successful message' do
        expect(page).to have_content 'Contact successfully deleted.'
      end

      it 'does not display the contact' do
        expect(page).not_to have_content contact.body
      end
    end
  end
end

