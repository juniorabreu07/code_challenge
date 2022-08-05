require 'rails_helper'
RSpec.describe "/buies", type: :request do

  before(:each) do
    create(:random_category)
    create(:random_product)
  end

  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    build(:random_buy)
  }

  let(:invalid_attributes) {
    { id: nil, namess:'s', morfosis: '1'}
    # skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # BuysController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    @auth_headers
  }

  describe "GET /index" do
    it "renders a successful response" do

      Buy.create! valid_attributes.as_json
      get buies_path, headers: valid_headers, as: :json
      # payload = JSON.parse(response.body)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      categorie = Buy.create! valid_attributes.as_json
      get buies_url(categorie), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Buy" do
        expect {
          post buies_path,
            params: { buy: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Buy, :count).by(1)
      end

      it "renders a JSON response with the new categorie" do
        post buies_path,
            params: { buy: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Buy" do
        post buies_path, params: { buy: invalid_attributes }, as: :json
        expect(Buy.count).to eq(0)
      end

      it "renders a JSON response with errors for the new categorie" do
        post buies_path,
        params: { buy: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        # skip("Add a hash of attributes valid for your model")
        build(:random_buy)
      }

      it "updates the requested categorie" do
        categorie = Buy.create! valid_attributes.as_json
        new_attributes[:id] = categorie.id
        patch "#{buies_path}/#{categorie.id}",params: { buy: new_attributes }, headers: valid_headers, as: :json
        categorie.reload
        # skip("Add assertions for updated state")
      end

      it "renders a JSON response with the categorie" do
        categorie = Buy.create! valid_attributes.as_json
        new_attributes[:id] = categorie.id
        patch "#{buies_path}/#{categorie.id}",params: { buy: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the categorie" do
        categorie = Buy.create! valid_attributes.as_json
        invalid_attributes[:id] = categorie.id
        patch "#{buies_path}/#{categorie.id}", params: { buy: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested categorie" do
      categorie = Buy.create! valid_attributes.as_json
      expect {
        delete "#{buies_path}/#{categorie.id}", headers: valid_headers, as: :json
      }.to change(Buy, :count).by(-1)
    end
  end
end