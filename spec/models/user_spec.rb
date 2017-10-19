require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {build(:user)}

  context 'expect to have columns' do 
    it do 
      should have_db_column(:name)
      should have_db_column(:email)
      should have_db_column(:password_digest)
    end 
  end 

  context 'validations' do 
    describe 'should vaidates the presence' do 
      it { should validate_presence_of(:email)}
      it { should validate_presence_of(:name)}
    end 

    describe 'should validate the uniquesness' do 
      it { should validate_uniqueness_of(:email)}
    end 

    describe 'should raise error for invalid email' do 
      it do 
        user = User.create(name: 'waikit', email: '123123.com', password: '1234')
        a = user.save 
        expect(a).to be(false)
      end 
    end 
  end 

  describe 'should have many restaurants' do 
      it {should have_many(:restaurants)}
  end 

  context 'unauthorized login' do 
    it 'should not allow unauthorized login' do 
      login = User.find_by(email: 'wkitsin99@hotmail.com').try(:authenticate, 'abc') 
      expect(login).to be(false)
    end 
  end 
end  