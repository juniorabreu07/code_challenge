require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do
    it "validate presence of required fields" do
      should validate_presence_of(:name)
      should validate_presence_of(:price)
      should validate_presence_of(:category_id)
    end
    it "validate relations" do
      should belong_to(:category)
    end
  end
end