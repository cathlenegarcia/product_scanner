require 'rails_helper'

RSpec.describe BasketPriceCalculator do
  subject(:call) { described_class.new(basket).call }

  let(:basket) { create(:basket) }
  let(:product1) { create(:product, price_cents: 1000) }
  let(:product2) { create(:product, price_cents: 2000) }

  describe '#call' do
    context 'when basket has items' do
      before do
        create(:basket_item, basket: basket, product: product1, quantity: 2)
        create(:basket_item, basket: basket, product: product2, quantity: 3)
      end

      it 'calculates total price correctly' do
        expect(call).to eq(8000)
      end
    end

    context 'when basket is empty' do
      it 'returns zero' do
        expect(call).to eq(0)
      end
    end

    context 'when basket has items with zero quantity' do
      before do
        create(:basket_item, basket: basket, product: product1, quantity: 0)
        create(:basket_item, basket: basket, product: product2, quantity: 3)
      end

      it 'calculates total price correctly' do
        expect(call).to eq(6000)
      end
    end
  end
end
