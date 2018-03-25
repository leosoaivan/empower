require 'rails_helper'

describe ClientsController, type: :controller do
  let(:user) { create(:user) }
  let(:client) { create(:client) }
  let(:valid_params) { attributes_for(:client) } 
  let(:invalid_params) { attributes_for(:client, lastname: "") }

  before :each do
    login user
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
          params: { client: valid_params }          
        }.to change(Client, :count).by 1
      end
      
      it "returns a redirect response" do
        post :create, params: { client: valid_params }
        expect(response).to have_http_status(302)
      end
    end
    
    context "with invalid params" do
      it "does not create a new client" do
        expect{
          post :create,
          params: { client: invalid_params }          
        }.to_not change(Client, :count)
      end

      it "renders the new template" do
        post :create, params: { client: invalid_params }
        expect(response).to render_template(:new)
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
        patch :update, params: { id: client.id, client: valid_params }
        expect(response).to have_http_status(302)
      end
    end

    context "with invalid params" do
      it "renders the edit template" do
        patch :update, params: { id: client.id, client: invalid_params }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let! (:petitioner) { create(:client) }

    context "with no related episodes" do
      it "deletes a client" do
        expect{
          delete :destroy, 
          params: { id: petitioner.id }
        }.to change(Client, :count).by -1
      end

      it "returns a redirect response" do
        delete :destroy, params: { id: petitioner.id }
        expect(response).to have_http_status(302)
      end
    end

    context "with related episodes" do
      before :each do
        create(:episode, petitioner_id: petitioner.id)
      end

      it "does not delete a client" do
        expect{ 
          delete :destroy, 
          params: { id: petitioner.id }
        }.to_not change(Client, :count)
      end

      it "renders the show template" do
        delete :destroy, params: { id: petitioner.id }
        expect(response).to render_template(:show)
      end
    end
  end
end