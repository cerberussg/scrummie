FactoryBot.define do
  factory :task do
    type { "" }
    title { "MyString" }
    is_completed { false }
  end
end
