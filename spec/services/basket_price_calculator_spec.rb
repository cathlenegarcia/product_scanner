require 'rails_helper'

RSpec.describe BasketPriceCalculator do
  subject(:call) { described_class.new(basket).call }

  let(:basket) { create(:basket) }

  describe '#call' do
    context 'when no discounts' do
      let(:product1) { create(:product, price_cents: 1000) }
      let(:product2) { create(:product, price_cents: 2000) }

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

    context 'with buy one get one free products' do
      let(:product) { create(:product, product_code: 'GR1', price_cents: 311) }

      context 'with even quantity' do
        before do
          create(:basket_item, basket: basket, product: product, quantity: 2)
        end

        it 'applies BOGO discount correctly' do
          expect(call).to eq(311)
        end
      end

      context 'with odd quantity' do
        before do
          create(:basket_item, basket: basket, product: product, quantity: 3)
        end

        it 'applies BOGO discount and charges for the extra item' do
          expect(call).to eq(622)
        end
      end
    end

    context 'with bulk discount products' do
      let(:product) { create(:product, product_code: 'SR1', price_cents: 500) }

      before do
        create(:basket_item, basket: basket, product: product, quantity: 3)
      end

      it 'applies bulk discount correctly' do
        expect(call).to eq(1350)
      end

      context 'with product without bulk discount' do
        let(:product) { create(:product, price_cents: 1000) }

        it 'charges regular price' do
          expect(call).to eq(3000)
        end
      end
    end

    context 'with mixed products' do
      let(:bogo_product) { create(:product, product_code: 'GR1', price_cents: 311) }
      let(:bulk_product_1) { create(:product, product_code: 'SR1', price_cents: 500) }
      let(:bulk_product_2) { create(:product, product_code: 'CF1', price_cents: 1123) }


      context 'with buy one get one free promo' do
        before do
          create(:basket_item, basket: basket, product: bogo_product, quantity: 3)
          create(:basket_item, basket: basket, product: bulk_product_1, quantity: 1)
          create(:basket_item, basket: basket, product: bulk_product_2, quantity: 1)
        end

        it 'applies buy one get one free discount correctly' do
          expect(call).to eq(2245)
        end
      end

      context 'with buy one get one free promo' do
        before do
          create(:basket_item, basket: basket, product: bogo_product, quantity: 2)
          create(:basket_item, basket: basket, product: bulk_product_1, quantity: 3)
          create(:basket_item, basket: basket, product: bulk_product_2, quantity: 4)
        end

        it 'applies both discounts correctly' do
          expect(call).to eq(4655)
        end
      end
    end
  end
end
