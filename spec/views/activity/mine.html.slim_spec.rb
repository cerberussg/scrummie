require 'rails_helper'

RSpec.describe "activity/mine.html.slim", type: :view do
  before do
    allow(view).to receive(:current_date)
      .and_return(Date.today.strftime('%a %d %b %Y'))
    assign(:standups, [FactoryBot.create(:standup)])
  end
  it "renders the word My Activity" do
      render :template => "activity/mine.html.slim"
      expect(rendered).to match /My Activity/
  end
end
