FactoryBot.define do
  factory :user do
    sequence(:first_name) { |n| Faker::Name.unique.first_name }
    sequence(:last_name) { |n| Faker::Name.unique.last_name }

    username { Faker::Internet.username(specifier: [first_name, last_name].join(' ')) }
    email { Faker::Internet.email(name: [first_name, last_name].join(' '), domain: 'example.com') }
    mobile { rand.to_s[2..11] }
    password { 'Password11$$' }
  end
end
