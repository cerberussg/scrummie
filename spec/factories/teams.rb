FactoryBot.define do
  factory :team do
    name { "MyString" }
    account
    timezone { "Arizona" }
    has_reminder { false }
    has_recap { false }
    hash_id { "MyString" }
    reminder_time { "2018-10-01 15:48:44" }
    recap_time { "2018-10-01 15:48:44" }
  end
end
