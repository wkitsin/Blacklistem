require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:user) {build(:user)}
  let(:restaurant) {build(:restaurant)}
  let(:restaurant1) {build(:restaurant1)}
  let(:restaurant2) {build(:restaurant2)}
  # FactoryGirl.create(:restaurant1)
  context 'expect to have columns' do 
    it do 
      should have_db_column(:latitude)
      should have_db_column(:longitude)
      should have_db_column(:adress)
      should have_db_column(:description)
    end 
  end 

  context 'validations' do 
    describe 'should validates the prensece of adress to be true' do 
      it { should validate_presence_of(:adress)}
    end 
  end 

  context 'relationship' do 
    describe 'should belong to user' do 
      it {should belong_to(:user)}
    end 
  end  

  context 'geocode' do 
    describe 'should return the latitude and longtude of a given adress' do 
      it do 
        # byebug 
        res = restaurant.save 
        lat = restaurant.latitude
        lng = restaurant.longitude
        expect(lat).should_not be_nil
        expect(lng).should_not be_nil
      end 
    end 
  end 

  context 'updating' do 
    describe 'should be able to update the lat and lng without changing the address' do 
      it do 
        res = restaurant1.save 
        lat = restaurant1.latitude
        lng = restaurant1.longitude
        update = restaurant1.update(adress: 'sri kuala lumpur')
        new_lat = restaurant1.latitude
        new_lng = restaurant1.longitude
        expect(lat).to equal(new_lat)
        expect(lat).to equal(new_lat)
        # byebug 
        expect(restaurant1.adress).to eq('sri kuala lumpur')
      end 
    end 
  end 

  context 'search ' do 
    describe 'should return both restaurants when i search damansara and chilli' do
      it do 
        Restaurant.destroy_all 
        restaurant.save 
        restaurant1.save 
        restaurant2.save 
        search = Restaurant.adress('damansara chilli asd')
        expect(search.count).to eq(2)
      end 
    end
  end 

  context ' maps method should return a hash' do 
    it 'maps(res)' do 
       Restaurant.destroy_all 
       restaurant.save 
       restaurant1.save 
       restaurant2.save 
       res = Restaurant.all 
       @hash = Restaurant.maps(res) 
       expect(@hash.first[:lat]).to eq(Restaurant.first.latitude)
       expect(@hash.second[:infowindow]).to eq(Restaurant.second.adress)
       expect(@hash.third[:lng]).to eq(Restaurant.third.longitude)
    end 
  end 
end 