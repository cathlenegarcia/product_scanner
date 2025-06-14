require 'rails_helper'

RSpec.describe Basket, type: :model do
  it { is_expected.to monetize(:total_price) }
  it { is_expected.to have_many(:basket_items) }
end
