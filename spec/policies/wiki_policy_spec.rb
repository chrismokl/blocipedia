# _spec in filename is important, otherwise you'll get cryptic non-funcitonality
#rails magic? rpsec expectation, won't autoload test got it

require 'rails_helper'

describe WikiPolicy do
  # common to both contexts
  let(:user) { User.create(email: 'test@example.com', password: '12345678') } # This is one place where factories will help us clean up such dependencies as the devise validations

  context 'for a public wiki' do
    let(:wiki) { Wiki.create(privacy: false) }  # happens freshly every time (`let`)

    it 'should permit update' do
      expect(WikiPolicy.new(user, wiki).update?).to eq(true)
    end
  end

  context 'for a private wiki' do
    let(:wiki) { Wiki.create(privacy: true) }

    context 'for a collaborator' do
      before{ Collaboration.create(wiki: wiki, user: user) }  # doesn't need to be a `let`, because we don't need to refer to this collaboration directly

      it 'should permit update' do
        expect(WikiPolicy.new(user, wiki).update?).to eq(true)
      end
    end

    context 'for a non-collaborator' do
      it 'should not permit update' do
        expect(WikiPolicy.new(user, wiki).update?).to eq(false)
      end
    end
  end
end