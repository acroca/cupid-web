FactoryGirl.define do
  factory :pretender do
    sequence(:name) {|i| "Pretender #{i}" }
  end

  factory :couple do
    association :pretender_a, factory: "pretender"
    association :pretender_b, factory: "pretender"
  end
end