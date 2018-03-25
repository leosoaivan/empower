require 'rails_helper'

describe ContactsController, type: :controller do
  let(:user) { create(:user) }
  let(:petitioner) { create(:client) }
  let(:episode) { create(:episode, petitioner_id: petitioner.id) }
  let(:contact) { create(:contact, episode: episode, user: user) }
  let!(:service_type) { create(:service_type, name: 'crisis') }
  let!(:service) { create(:service, name: 'provided shelter', service_type: service_type) }
  let(:valid_params) {
    {
      episode_id: episode.id,
      contact: attributes_for(:contact, services:[service], user_id: user.id)
    }
  }
  let(:invalid_params) {
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

  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: contact.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "returns a redirect response" do
        patch :update, params: { id: contact.id, contact: { body: 'X'} }
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "returns a successful response" do
        patch :update, params: { id: contact.id, contact: { body: ''} }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys a contact" do
      contact
      
      expect{
        delete :destroy,
        params: {
          episode_id: episode.id,
          id: contact.id
        },
        xhr: true
      }.to change(Contact, :count).by -1
    end

    it "returns a success response" do
      contact
      
      delete :destroy,
      params: {
        episode_id: episode.id,
        id: contact.id
      },
      xhr: true
      expect(response).to have_http_status(200)
    end
  end
end
