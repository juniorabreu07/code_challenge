require 'rails_helper'
RSpec.describe "/products", type: :request do

  before(:each) do
    create(:random_category)

  end

  let(:valid_attributes) {
    # skip("Add a hash of attributes valid for your model")
    build(:random_product)
  }

  let(:invalid_attributes) {
    { id: nil, namess:'s', morfosis: '1'}
    # skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # ProductsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    @auth_headers
  }

  describe "GET /index" do
    it "renders a successful response" do

      Product.create! valid_attributes.as_json
      get products_path, headers: valid_headers, as: :json
      # payload = JSON.parse(response.body)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      categorie = Product.create! valid_attributes.as_json
      get products_url(categorie), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Product" do
        expect {
          post products_path,
            params: { product: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Product, :count).by(1)
      end

      it "renders a JSON response with the new categorie" do
        post products_path,
            params: { product: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Product" do
        post products_path, params: { product: invalid_attributes }, as: :json
        expect(Product.count).to eq(0)
      end

      it "renders a JSON response with errors for the new categorie" do
        post products_path,
        params: { product: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        # skip("Add a hash of attributes valid for your model")
        build(:random_product)
      }

      it "updates the requested categorie" do
        categorie = Product.create! valid_attributes.as_json
        new_attributes[:id] = categorie.id
        patch "#{products_path}/#{categorie.id}",params: { product: new_attributes }, headers: valid_headers, as: :json
        categorie.reload
        # skip("Add assertions for updated state")
      end

      it "renders a JSON response with the categorie" do
        categorie = Product.create! valid_attributes.as_json
        new_attributes[:id] = categorie.id
        patch "#{products_path}/#{categorie.id}",params: { product: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the categorie" do
        categorie = Product.create! valid_attributes.as_json
        invalid_attributes[:id] = categorie.id
        patch "#{products_path}/#{categorie.id}", params: { product: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested categorie" do
      categorie = Product.create! valid_attributes.as_json
      expect {
        delete "#{products_path}/#{categorie.id}", headers: valid_headers, as: :json
      }.to change(Product, :count).by(-1)
    end
  end
end