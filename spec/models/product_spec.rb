require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "validations" do

    it "validate relations" do
      should belong_to(:category)
    end
  end
end