require 'rails_helper'

RSpec.describe "/support.html.slim", type: :view do
  it 'renders How to reach support?' do
    render :template => "static/support.html.slim"
    expect(rendered).to match /How to reach support?/
  end
end
