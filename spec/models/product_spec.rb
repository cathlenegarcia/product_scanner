require 'rails_helper'

RSpec.describe Product, type: :model do
  it { is_expected.to monetize(:price_cents) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:product_code) }
    context 'when product_code is unique' do
      subject! { create(:product) }

      it { is_expected.to validate_uniqueness_of(:product_code) }
    end
  end
end
