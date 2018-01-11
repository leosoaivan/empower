require 'rails_helper'

describe ContactsController, type: :controller do
  let (:user) { create(:user) }
  let (:petitioner) { create(:client) }
  let (:episode) { create(:episode, petitioner_id: petitioner.id) }

  before :each do
    login user
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new, 
      params: {
        client_id: petitioner.id,
        episode_id: episode.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    let (:valid_params) {
      {
        client_id: petitioner.id,
        episode_id: episode.id,
        contact: { body: "This is a contact body." }
      }
    }
    let (:invalid_params) {
      {
        client_id: petitioner.id,
        episode_id: episode.id,
        contact: { body: "" }
      }
    }

    context "with valid params" do
      it "creates a new contact" do
        expect{
          post :create,
          params: valid_params
        }.to change(Contact, :count).by 1
      end

      it "returns a redirect response" do
        post :create, 
        params: valid_params
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "does not create a new contact" do
        expect{
          post :create,
          params: invalid_params
        }.to_not change(Contact, :count)
      end

      it "returns a successful response" do
        post :create, 
        params: invalid_params
        expect(response).to have_http_status(200)
      end
    end

  end
end
