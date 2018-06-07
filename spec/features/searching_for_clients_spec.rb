require 'rails_helper'

feature 'Client search' do
  let (:user) { create(:user) }
  let! (:client_1) { 
    create(:client,
      firstname: 'Kevin',
      lastname: 'Smith') 
  }
  let! (:client_2) { 
    create(:client,
      firstname: 'Janice',
      lastname: 'Smith') 
  }
  let! (:client_3) { 
    create(:client,
      firstname: 'Kevin',
      lastname: 'Hopper') 
  }
  let! (:client_4) { 
    create(:client,
      firstname: 'Janice',
      lastname: 'Hopper') 
  }

  let (:client_data) { '.card' }

  before :each do
    log_in user
    visit clients_path
  end

  describe 'arriving at search page' do
    it 'shows a search form' do
      expect(page).to have_css 'form'
    end

    it 'shows search result cards' do
      expect(page).to have_css '.card'
    end

    it 'returns all clients' do
      expect(page).to have_css '.card', count: Client.count
    end
  end

  describe 'searching by ID' do
    context 'with a valid ID' do
      before :each do
        fill_in 'where_id', with: client_1.id
        click_button 'Search'
      end
      
      it 'returns a match' do
        expect(page).to have_css client_data, count: 1
      end
      
      it 'returns a specific client' do
        expect(find(client_data)).to have_content client_1.id
      end
    end

    context 'with a valid ID and valid full name' do
      before :each do
        fill_in 'where_id', with: client_1.id
        fill_in 'where_firstname_like', with: client_1.firstname
        fill_in 'where_lastname_like', with: client_1.lastname
        click_button 'Search'
      end

      it 'returns a match' do
        expect(find(client_data)).to have_content client_1.id
      end

      it 'returns one specific client' do
        expect(page).to have_css client_data, count: 1
      end
    end

    context 'with a valid ID, valid firstname, and invalid lastname' do
      it 'returns no hits' do
        fill_in 'where_id', with: client_1.id
        fill_in 'where_firstname_like', with: client_1.firstname
        fill_in 'where_lastname_like', with: 'Grace'
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end

    context 'with a valid ID, invalid firstname, and valid lastname' do
      it 'returns no hits' do
        fill_in 'where_id', with: client_1.id
        fill_in 'where_firstname_like', with: 'Topher'
        fill_in 'where_lastname_like', with: 'Smith'
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end

    context 'with an invalid ID' do      
      it 'returns no hits' do
        fill_in 'where_id', with: 100
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end

    context 'with an invalid ID, valid firstname, and invalid lastname' do
      it 'returns no hits' do
        fill_in 'where_id', with: 100
        fill_in 'where_firstname_like', with: client_1.firstname
        fill_in 'where_lastname_like', with: 'Grace'
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end

    context 'with an invalid ID, invalid firstname, and valid lastname' do
      it 'returns no hits' do
        fill_in 'where_id', with: 100
        fill_in 'where_firstname_like', with: 'Topher'
        fill_in 'where_lastname_like', with: client_1.lastname
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end
  end
  
  describe 'searching by name only' do
    context 'with a valid firstname' do
      it 'returns match(es)' do
        fill_in 'where_firstname_like', with: client_1.firstname
        click_button 'Search'
        expect(page).to have_css client_data, count: 2
      end
    end

    context 'with a partial firstname' do
      it 'returns match(es)' do
        fill_in 'where_firstname_like', with: client_1.firstname[0, 3]
        click_button 'Search'
        expect(page).to have_css client_data, count: 2
      end
    end

    context 'with a valid lastname' do
      it 'returns match(es)' do
        fill_in 'where_lastname_like', with: client_1.lastname
        click_button 'Search'
        expect(page).to have_css client_data, count: 2
      end
    end

    context 'with a partial lastname' do
      it 'returns match(es)' do
        fill_in 'where_lastname_like', with: client_1.lastname[0, 3]
        click_button 'Search'
        expect(page).to have_css client_data, count: 2
      end
    end

    context 'with valid firstname AND lastname' do
      it 'returns match(es)' do
        fill_in 'where_firstname_like', with: client_1.firstname
        fill_in 'where_lastname_like', with: client_1.lastname
        click_button 'Search'
        expect(page).to have_css client_data, count: 1
      end
    end

    context 'with partial firstname AND lastname' do
      it 'returns match(es)' do
        fill_in 'where_firstname_like', with: client_1.firstname[0, 3]
        fill_in 'where_lastname_like', with: client_1.lastname[0, 3]
        click_button 'Search'
        expect(page).to have_css client_data, count: 1
      end
    end

    context 'with an invalid first name' do
      it 'returns no hits' do
        fill_in 'where_firstname_like', with: client_1.firstname
        fill_in 'where_lastname_like', with: 'Mike'
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end

    context 'with an invalid last name' do
      it 'returns no hits' do
        fill_in 'where_firstname_like', with: 'Topher'
        fill_in 'where_lastname_like', with: client_1.lastname
        click_button 'Search'
        expect(page).to_not have_css client_data
      end
    end
  end

  describe 'clicking on view button' do
    it 'navigates user to client\'s page' do
      fill_in 'where_firstname_like', with: client_1.firstname
      fill_in 'where_lastname_like', with: client_1.lastname
      click_button 'Search'
      within('.card .card-action') do
        click_on 'VIEW'
      end
      expect(current_path).to eql client_path(client_1)
    end
  end
end
