require 'rails_helper'

describe 'Episode management -', type: :feature do
  let (:petitioner) { create(:client) }

  before :each do
    log_in create(:user_staff)
  end
  
  describe 'creating an episode', js: true do
    before :each do
      visit client_path(petitioner)
      click_on 'Create new episode'
    end

    it 'directs to the episode creation page' do
      expect(current_path).to eql new_client_episode_path(petitioner)
    end

    it 'displays a form' do
      expect(page).to have_css 'form'
    end

    context 'with a created respondent and valid attributes' do
      before :each do
        click_on 'add-respondent__create-button'
        fill_in 'respondent_firstname', with: 'Jack'
        fill_in 'respondent_lastname', with: 'Black'
        within '#respondent-info-arrest' do
          choose 'Yes', allow_label_click: true
        end
        check 'Now or previously married', allow_label_click: true
        check 'Intimate partner violence', allow_label_click: true
        click_on 'Create Episode'
      end
      
      it 'flashes a successful message' do
        expect(page).to have_css '.flash__alert--success'
      end

      it 'redirects back to the client\'s page' do
        expect(current_path).to eql client_path(petitioner)
      end

      it 'displays the new episode' do
        expect(page).to have_selector(
          '.episode-card', text: 'Now or previously married')
      end

      it 'displays the respondent\'s information' do
        within '.episode-card' do
          expect(page).to have_content 'Jack Black'
        end
      end
    end

    context 'with a searched respondent' do
      let!(:respondent) { create(:client) }

      before :each do
        click_on 'add-respondent__search-button'
        fill_in 'respondent_fullname', with: respondent.firstname[0..2]
      end

      it 'displays a drop down with the respondent\'s name' do
        expect(page).to have_css('.autocomplete-content', text: respondent.firstname)
      end
    end

    context 'with no respondent and valid attributes' do
      before :each do
        check 'Now or previously married', allow_label_click: true
        check 'Intimate partner violence', allow_label_click: true
        click_on 'Create Episode'
      end

      it 'flashes a successful message' do
        expect(page).to have_css '.flash__alert--success'
      end
    end

    context 'with invalid attributes' do
      before :each do
        click_on 'Create Episode'
      end

      it 'flashes a danger message' do
        expect(page).to have_css '.flash__alert--danger'
      end

      it 'returns the form' do
        expect(page).to have_css 'form'
      end
    end
  end

  describe 'cancelling an episode', js: true do
    before :each do
      visit client_path(petitioner)
      click_on 'Create new episode'
      click_on 'add-respondent__create-button'
      fill_in 'respondent_firstname', with: 'Jack'
      click_on 'episode-form__button--cancel'
    end

    it 'redirects back to a client page' do
      expect(current_path).to eql client_path(petitioner)
    end

    it 'does not display a new episode' do
      expect(page).not_to have_content 'Jack Black'
    end
  end

  describe 'deleting an episode', js: true do
    let! (:episode) { create(:episode, petitioner_id: petitioner.id) }
    
    before :each do
      visit client_path(petitioner)
      accept_confirm do
        click_on 'Delete episode'
      end
    end
    
    it 'flashes a successful message' do
      expect(page).to have_css '.flash__alert--success'
    end
    
    it 'redirects a user back to the client\'s page' do
      expect(current_path).to eql client_path(petitioner)
    end
    
    it 'does not display the episode' do
      expect(page).to have_content 'There are no episodes for this client'
    end
  end
end