require 'rails_helper'

RSpec.describe Batch, type: :model do
  it { should validate_uniqueness_of(:reference) }

  describe "presence validations" do
    it { should validate_presence_of(:purchase_channel) }
    it { should validate_presence_of(:group_orders) }
  end
end
