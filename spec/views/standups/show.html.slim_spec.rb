require 'rails_helper'

RSpec.describe "standups/show", type: :view do
  before(:each) do
    @standup = assign(:standup, Standup.create!(
      :user => nil,
      :hash_id => "Hash"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Hash/)
  end
end
