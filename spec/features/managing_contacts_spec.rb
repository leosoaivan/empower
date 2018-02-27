require 'rails_helper'

feature 'Contacts management' do
  let (:user) { create(:user) }
  let (:client) { create(:client) }
  let! (:episode) { create(:episode, petitioner_id: client.id) }
  let! (:contact) { 
    create(
      :contact, 
      episode_id: episode.id, 
      user_id: user.id,
      body: 'This is a new contact.'
    )
  }
  let (:alert_danger) { '.flash__alert--danger' }
  let (:alert_success) { '.flash__alert--success' }
  
  before :each do
    log_in user
    visit client_path(client)
    click_on 'View episode'
  end
  
  describe 'creating a contact' do
    before :each do
      click_on 'Create contact'
    end

    it 'displays a form' do
      expect(page).to have_css 'form'
    end
    
    context 'with a valid body' do
      before :each do
        fill_in 'Body', with: 'This is a contact body.'
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
    end

    context 'with an invalid body' do
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

  describe 'editing a contact' do
    before :each do
      click_on 'Edit contact'
    end
    
    context 'with a valid body' do
      before :each do
        fill_in 'Body', with: 'This is an edited contact.'
        click_on 'Edit Contact'
      end

      it 'displays a successful message' do
        expect(page).to have_css alert_success
      end

      it 'redirects a user back to the episode' do
        expect(current_path).to eql episode_path(episode)
      end

      it 'displays the newly added contact' do
        expect(page).to have_content 'This is an edited contact.'
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
    before :each do
      accept_confirm do
        click_on 'Delete contact'
      end
    end

    it 'flashes a successful message' do
      expect(page).to have_css alert_success
    end

    it 'redirects back to the episode page' do
      expect(current_path).to eql episode_path(episode)
    end

    it 'does not display the contact' do
      expect(page).not_to have_content contact.body
    end
  end
end

