require 'rails_helper'

RSpec.describe BasketItem, type: :model do
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:basket) }

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:quantity).only_integer.is_greater_than_or_equal_to(0) }

    context 'when basket_id and product_id are unique' do
      subject! { create(:basket_item) }

      it { is_expected.to validate_uniqueness_of(:basket_id).scoped_to(:product_id).ignoring_case_sensitivity }
    end
  end
end
