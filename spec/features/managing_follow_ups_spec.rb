require 'rails_helper'

describe 'Follow Ups management -', type: :feature do

  let (:user) { FactoryBot.create(:user_staff) }
  let (:assignee) { FactoryBot.create(:user_staff) }
  let (:petitioner) { FactoryBot.create(:client) }
  let (:episode) { 
    FactoryBot.create(:episode, petitioner_id: petitioner.id) 
  }

  before :each do
    log_in user
    visit episode_path(episode)
    click_on 'Schedule follow-up'
  end

  describe 'creating a follow-up' do
    it 'displays a form for creating a follow-up' do
      expect(page).to have_css 'form'
    end

    context 'with valid params' do
      it 'displays the follow-up on the episode page', js: true do
        find('.datepicker').click
        first('.picker__day--infocus').click
        click_on 'Ok'
        find('.select-shift').click
        find('span', text: 'morning').click
        find('.select-user').click
        find('span', text: user.full_name).click
        click_on 'Create'
  
        expect(current_path).to eql episode_path(episode)
        within(:xpath, "//table[contains(@class, 'follow-ups__table')]/tbody") do
          expect(page).to have_css('tr', count: 1)
        end
      end
    end

    context 'with invalid params' do
      it 're-renders the form with an error message', js: true do
        click_on 'Create'

        expect(page).to have_css('.flash__alert--danger')
        expect(page).to have_css('form')
      end
    end
  end
end
