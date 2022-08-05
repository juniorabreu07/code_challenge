require 'rails_helper'

RSpec.describe Buy, type: :model do

  describe "validations" do

    it "validate presence of required fields" do
      should validate_presence_of(:price)
      should validate_presence_of(:total)
      should validate_presence_of(:quantity)
      should validate_presence_of(:product_id)
    end
    it "validate relations" do
      should belong_to(:product)
    end
  end
end