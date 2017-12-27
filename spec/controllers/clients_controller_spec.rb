require 'rails_helper'

describe ClientsController, type: :controller do
  let (:client) { create(:client) }
  let (:valid_params)   { { client: { firstname: "First", lastname: "Last" } } }
  let (:invalid_params) { { client: { firstname: "First", lastname: "" } } }

  before :each do
    login create(:user)
  end

  describe "GET #index" do
    it "returns a successful response" do
      get :index
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST #create" do
    context "with valid params" do
      it "creates a new client" do
        expect{
          post :create,
          params: valid_params          
        }.to change(Client, :count).by 1
      end
      
      it "returns a redirect response" do
        post :create, params: valid_params
        expect(response).to have_http_status(302)
      end
    end
    
    context "with invalid params" do
      it "does not create a new client" do
        expect{
          post :create,
          params: invalid_params          
        }.to_not change(Client, :count)
      end

      it "returns a successful response" do
        post :create, params: invalid_params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      get :show, params: { id: client.id }
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET #edit" do
    it "returns a successful response" do
      get :edit, params: { id: client.id }
      expect(response).to have_http_status(200)
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      it "returns a redirect response" do
        put :update, params: { id: client.id, client: { firstname: "Leo" } }
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "returns a successful response" do
        put :update, params: { id: client.id, client: { firstname: "" } }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe "DELETE #destroy" do
    let! (:petitioner) { create(:client) }
    let (:respondent) { create(:client) }

    context "with no related episodes" do
      it "deletes a client" do
        expect{
          delete :destroy, params: { id: petitioner.id }
        }.to change(Client, :count).by -1
      end

      it "returns a redirect response" do
        delete :destroy, params: { id: petitioner.id }
        expect(response).to have_http_status(302)
      end
    end

    context "with related episodes" do
      before :each do
        create(:episode,
          petitioner_id: petitioner.id,
          respondent_id: respondent.id
        )
      end

      it "does not delete a client" do
        expect{
          delete :destroy, params: { id: petitioner.id }
        }.to_not change(Client, :count)
      end

      it "returns a successful response" do
        expect(response).to have_http_status(200)
      end
    end
  end
end