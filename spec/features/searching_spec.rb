require 'rails_helper'

feature 'Search management' do
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
      expect(find('table')).to have_css('td.firstname', count: Client.count)
    end
  end

  describe "searching for clients" do
    context "with full firstname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: nil
        click_button 'Search'
        expect(page).to have_css('td.firstname', count: 2)
      end
    end

    context "with first few letters of firstname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname[0, 3]
        fill_in 'lastname', with: nil
        click_button 'Search'
        expect(page).to have_css('td.firstname', count: 2)
      end
    end

    context "with full lastname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: nil
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
        expect(page).to have_css('td.lastname', count: 2)
      end
    end

    context "with first few letters of lastname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: nil
        fill_in 'lastname', with: client1.lastname[0, 3]
        click_button 'Search'
        expect(page).to have_css('td.lastname', count: 2)
      end
    end

    context "with firstname AND lastname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: client1.lastname
        click_button 'Search'
        expect(page).to have_css('td.firstname', count: 1)
      end
    end

    context "with first few letters of both firstname AND lastname" do
      it "edits the table with matching results" do
        fill_in 'firstname', with: client1.firstname[0, 3]
        fill_in 'lastname', with: client1.lastname[0, 3]
        click_button 'Search'
        expect(page).to have_css('td.firstname', count: 1)
      end
    end

    context "with an incorrect query" do
      it "returns a blank table" do
        fill_in 'firstname', with: client1.firstname
        fill_in 'lastname', with: "Mike"
        click_button 'Search'
        expect(page).to_not have_css('td.firstname')
      end
    end
  end
end
