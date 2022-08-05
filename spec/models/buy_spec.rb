require 'rails_helper'

RSpec.describe Buy, type: :model do

  describe "validations" do

    it "validate relations" do
      should belong_to(:product)
    end
  end
end