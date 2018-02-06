require 'rails_helper'

describe EpisodesController, type: :controller do
  let (:user) { create(:user) }
  let (:client) { create(:client) }
  let (:valid_params) { 
    {
      client_id: client.id,
      episode: attributes_for(:episode)
    }
  }
  let (:invalid_params) { 
    {
      client_id: client.id,
      episode: attributes_for(:episode, relationship: nil)
    }
  }

  before :each do
    login user
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new, params: { client_id: client.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new episode" do
        expect{
          post :create, 
          params: valid_params
        }.to change(Episode, :count).by 1
      end

      it "returns a redirect response" do
        post :create, params: valid_params
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "does not create new episode" do
        expect{
          post :create,
          params: invalid_params
        }.to_not change(Episode, :count)
      end

      it "returns a successful response" do
        post :create, params: invalid_params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let! (:episode) { create(:episode, petitioner_id: client.id) }

    it "deletes an episode" do
      expect{
        delete :destroy,
        params: { id: episode.id }
      }.to change(Episode, :count).by -1 
    end

    it "returns a redirect response" do
      delete :destroy,
      params: { id: episode.id }
      expect(response).to have_http_status(302)
    end
  end
end