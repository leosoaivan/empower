require 'rails_helper'

describe 'Users management -', type: :feature do
  let (:staff) { FactoryBot.create(:user_staff) }
  let (:client) { FactoryBot.create(:client) }
  let (:episode) { FactoryBot.create(:episode, petitioner_id: client.id) }
  let (:contacts) do
    FactoryBot.create_list(:contact,
                           5,
                           user_id: staff.id,
                           episode_id: episode.id
    )
  end

  describe 'viewing the homepage' do
    before :each do
      contacts
      log_in staff
    end

    it 'renders the user\'s profile' do
      expect(current_path).to eql(authenticated_root_path)
      expect(page).to have_content(staff.full_name)
    end

    it 'displays a table of contacts' do
      expect(page).to have_css('table')
      within 'tbody' do
        expect(page).to have_css('tr', count: contacts.count)
      end
    end
  end

  describe 'viewing contacts on the homepage' do
    let (:new_contact) do
      FactoryBot.create(:contact,
                        body: 'The newest contact',
                        user_id: staff.id,
                        episode_id: episode.id
      )
    end

    before :each do
      new_contact
      log_in staff
    end

    it 'displays the contacts in descending order' do
      expect(page).to have_css('tbody/tr:nth-child(1)', text: new_contact.body)
    end

    # it 'displays a link to a related episode' do
    #   within('tbody/tr:nth-child(1)') do
    #     find('a').click
    #   end
      
    #   expect(current_path).to eql episode_path(episode)
    # end
  end

  describe 'viewing another user\'s homepage' do
    it 'renders that user\'s profile' do
      another_user = FactoryBot.create(:user)
      log_in staff
      visit user_path(another_user)

      expect(page).to have_content(another_user.full_name)
    end
  end
end