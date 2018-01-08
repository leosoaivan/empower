require 'rails_helper'

xdescribe ContactsController, type: :controller do
  let! (:petitioner) { create(:client) }
  let! (:episode) { create(:episode, petitioner_id: petitioner.id) }

  before :each do
    login create(:user)
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
          params: { 
            episode_id: episode.id,
            contact: { body: "This is a contact body." }
          }
        }.to change(Contact, :count).by 1
      end

      it "returns a redirect response" do
        post :create, 
        params: {
          episode_id: episode.id, 
          contact: { body: "This is a contact body." }
        }
        expect(response).to have_http_status(302)
      end
    end
  end
end
