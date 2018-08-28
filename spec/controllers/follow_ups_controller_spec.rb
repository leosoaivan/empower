require 'rails_helper'

describe FollowUpsController, type: :controller do
  let  (:staff) { FactoryBot.create(:user_staff) }
  let  (:petitioner) { FactoryBot.create(:client) }
  let! (:episode) { FactoryBot.create(:episode, petitioner_id: petitioner.id) }
  let  (:valid_params) {
    {
      episode_id: episode.id,
      follow_up: {
        user_id: staff.id,
        due_by_date: Date.current + 3.days,
        due_by_shift: 1
      }
    }
  }
  let  (:invalid_params) {
    {
      episode_id: episode.id,
      follow_up: {
        user_id: ""
      }
    }
  }

  before :each do
    sign_in staff
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { episode_id: episode.id }
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new follow-up' do
        expect{
          post :create,
          params: valid_params
        }.to change(FollowUp, :count).by 1
      end

      it 'redirects' do
        post :create,
        params: valid_params
        expect(response).to have_http_status(302)
      end
    end

    context 'with invalid params' do
      it 'does not create a new follow-up' do
        expect{
          post :create,
          params: invalid_params
        }.not_to change(FollowUp, :count)
      end

      it 're-renders the new page' do
        post :create,
        params: invalid_params

        expect(response).to have_http_status(200)
        expect(response).to render_template(:new)
      end
    end
  end
end
