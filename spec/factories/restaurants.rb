FactoryGirl.define do
  factory :restaurant do
    # latitude 3.052
    # longitude 100.5132
    adress 'Chilli Pan Mee, Uptown Damansara'
    description 'nasty food'
    user_id 10 
  end

  factory :restaurant1, :class => Restaurant do 
    adress 'NEXT academy, Damansara'
    user_id 10 
  end 

  factory :restaurant2, :class => Restaurant do 
    adress 'Sri Kuala Lumpur'
    user_id 10 
  end 

end