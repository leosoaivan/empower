require 'rails_helper'

describe ContactsController, type: :controller do
  let (:user) { create(:user) }
  let (:petitioner) { create(:client) }
  let (:episode) { create(:episode, petitioner_id: petitioner.id) }
  let (:valid_params) {
    {
      episode_id: episode.id,
      contact: attributes_for(:contact)
    }
  }
  let (:invalid_params) {
    {
      episode_id: episode.id,
      contact: attributes_for(:contact, body: "")
    }
  }

  before :each do
    login user
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new, params: { episode_id: episode.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
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

  describe "DELETE #destroy" do
    let! (:contact) {
      create(
        :contact, 
        user_id: user.id, 
        episode_id: episode.id
      )
    }

    it "destroys a contact" do
      expect{
        delete :destroy,
        params: {
          episode_id: episode.id,
          id: contact.id
        }
      }.to change(Contact, :count).by -1
    end

    it "returns a redirect response" do
      delete :destroy,
      params: {
        episode_id: episode.id,
        id: contact.id
      }
      expect(response).to have_http_status(302)
    end
  end
end
