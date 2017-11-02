require 'rails_helper'

feature 'Client search management' do
  let (:user) { FactoryGirl.create(:user) }
  let! (:client1) { 
    FactoryGirl.create(:client,
      firstname: "Kevin",
      lastname: "Smith") 
  }
  let! (:client2) { 
    FactoryGirl.create(:client,
      firstname: "Janice",
      lastname: "Smith") 
  }
  let! (:client3) { 
    FactoryGirl.create(:client,
      firstname: "Kevin",
      lastname: "Hopper") 
  }
  let! (:client4) { 
    FactoryGirl.create(:client,
      firstname: "Janice",
      lastname: "Hopper") 
  }

  let (:data_row) { 'tbody tr' }
  
  before :each do
    log_in(user)
    visit clients_path
  end

  describe "arriving at search page" do
    it "shows a search form" do
      expect(page).to have_css('form')
    end

    it "shows a results table" do
      expect(page).to have_css('table#search-results')
    end

    it "returns all clients" do
      expect(find('table')).to have_css(data_row, count: Client.count)
    end
  end

  describe "searching by ID" do
    context "with a valid ID" do
      before :each do
        fill_in 'id', with: client1.id
        click_button 'Search'
      end
      
      it "edits the table with matching result" do
        expect(find(data_row)).to have_content(client1.id)
      end

      it "returns a specific client" do
        expect(page).to have_css(data_row, count: 1)
      end
    end

    context "with a valid ID and valid full name" do
      before :each do
        fill_in 'id', with: client1.id
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
      end

      it "edits the table with matching result" do
        expect(find(data_row)).to have_content(client1.id)
      end

      it "returns a specific client" do
        expect(page).to have_css(data_row, count: 1)
      end
    end

    context "with a valid ID, valid firstname, and invalid lastname" do
      it "returns no hits" do
        fill_in 'id', with: client1.id
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: "Grace"
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end

    context "with a valid ID, invalid firstname, and valid lastname" do
      it "returns no hits" do
        fill_in 'id', with: client1.id
        fill_in 'firstname', with: "Topher"
        fill_in 'lastname', with: "Smith"
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end

    context "with an invalid ID" do      
      it "returns no hits" do
        fill_in 'id', with: 100
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end

    context "with an invalid ID, valid firstname, and invalid lastname" do
      it "returns no hits" do
        fill_in 'id', with: 100
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: "Grace"
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end

    context "with an invalid ID, invalid firstname, and valid lastname" do
      it "returns no hits" do
        fill_in 'id', with: 100
        fill_in 'firstname', with: "Topher"
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end
  end
  
  describe "searching by name only" do
    context "with a valid firstname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname
        click_button 'Search'
        expect(page).to have_css(data_row, count: 2)
      end
    end

    context "with a partial firstname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname[0, 3]
        click_button 'Search'
        expect(page).to have_css(data_row, count: 2)
      end
    end

    context "with a valid lastname" do
      it "edits the table with matching results" do
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
        expect(page).to have_css(data_row, count: 2)
      end
    end

    context "with a partial lastname" do
      it "edits the table with matching results" do
        fill_in 'lastname', with: client1.lastname[0, 3]
        click_button 'Search'
        expect(page).to have_css(data_row, count: 2)
      end
    end

    context "with valid firstname AND lastname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
        expect(page).to have_css(data_row, count: 1)
      end
    end

    context "with partial firstname AND lastname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname[0, 3]
        fill_in 'lastname', with: client1.lastname[0, 3]
        click_button 'Search'
        expect(page).to have_css(data_row, count: 1)
      end
    end

    context "with an invalid first name" do
      it "returns no hits" do
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: "Mike"
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end

    context "with an invalid last name" do
      it "returns no hits" do
        fill_in 'firstname', with: "Topher"
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
        expect(page).to_not have_css(data_row)
      end
    end
  end
end
