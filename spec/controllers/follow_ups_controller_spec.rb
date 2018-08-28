require 'rails_helper'

describe FollowUpsController, type: :controller do
  let  (:staff) { FactoryBot.create(:user_staff) }
  let  (:petitioner) { FactoryBot.create(:client) }
  let! (:episode) { FactoryBot.create(:episode, petitioner_id: petitioner.id) }
  let  (:valid_params) {
    {
      episode_id: episode.id,
      user_id: staff.id,
      due_by_date: Date.current + 3.days,
      due_by_shift: 1
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
    end
  end
end
