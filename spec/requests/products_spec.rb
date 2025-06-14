require 'rails_helper'

RSpec.describe 'Products', type: :request do
  describe '#index' do
    before { create_list(:product, 3) }

    subject! { get products_path }

    it 'returns http success and renders the index template' do
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(assigns(:products)).to eq(Product.all)
      expect(assigns(:products).count).to eq(3)
    end
  end
end
