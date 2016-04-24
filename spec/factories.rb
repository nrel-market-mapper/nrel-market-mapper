FactoryGirl.define do
  factory :zipcode do
    number "MyString"
    county nil
  end
  factory :county do
    name "MyString"
    state nil
  end
  factory :summary do
    year "MyString"
    avg_cost "9.99"
    capacity "9.99"
    total_installs 1
    state nil
  end
  factory :state do
    abbr "MyString"
    name "MyString"
  end
end
