require 'rails_helper'

RSpec.describe "standups/index", type: :view do
  before(:each) do
    assign(:standups, [
      Standup.create!(
        :user => nil,
        :hash_id => "Hash"
      ),
      Standup.create!(
        :user => nil,
        :hash_id => "Hash"
      )
    ])
  end

  it "renders a list of standups" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Hash".to_s, :count => 2
  end
end
