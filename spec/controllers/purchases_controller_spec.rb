require 'rails_helper'
require 'stripe_mock'

describe PurchasesController, type: :controller do
  describe '#create' do
    before {
      @request.env['HTTP_REFERER'] =  ''
    }
    context 'by a non premium user' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @user = User.create(
          username: 'dummyusername', 
          email:    'test@example.com', 
          password: '12345678')
        sign_in @user
      end

      before { StripeMock.start }
      after { StripeMock.stop }

      it 'makes that user a premium account' do
        post :create
        @user.reload
        expect(@user.premium).to eq(true)
      end
    end

  end

end