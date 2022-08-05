require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "validations" do

    it "validate relations" do
      should have_many(:product)
    end
  end
end