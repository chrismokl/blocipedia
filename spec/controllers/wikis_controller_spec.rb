require 'rails_helper'

describe WikisController do
  describe '#create' do
    context 'by a logged-in user' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = User.create(email: 'test@example.com', password: '12345678')
        sign_in user
      end

      it 'creates a new collaboration' do
        expect{
          post :create, wiki: {title: 'blahblahblah', body: 'refactor with factories'}
        }.to change(Collaboration, :count)
      end
    end

    context 'by an anonymous user' do
      it 'does not create a new collaboration' do
        expect{
          post :create, wiki: {title: 'blahblahblah', body: 'refactor with factories'}
        }.to_not change(Collaboration, :count)
      end
    end

    context 'by not a permium user' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = User.create(email: 'test@example.com', password: '12345678', premium: false)
        sign_in user
      end

      it 'does not create a wiki' do
        expect{
          post :create, wiki:{title: 'blahblahblah', body: 'refactor with factories', privacy: true}
        }.to_not change(Wiki, :count)
      end
    end

    context 'by a permium user' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = User.create(email: 'test@example.com', password: '12345678', premium: true)
        sign_in user
      end

      it 'does create a wiki' do
        expect{
          post :create, wiki:{title: 'blahblahblah', body: 'refactor with factories', privacy: true}
        }.to change(Wiki, :count)
      end
    end
  end

  describe '#edit' do
    let(:wiki) { Wiki.create(title: 'dummy wiki') }

    context 'by a logged-in user' do
      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        user = User.create(email: 'test@example.com', password: '12345678')
        sign_in user
      end

      it 'returns success' do
        get :edit, wiki_id: wiki.slugged
        expect(response).to eq(200)
      end
    end  
  end
end