require 'rails_helper'

RSpec.describe 'users/index.html.erb', type: :view do
  it "displays the expected content" do
    render
    expect(rendered).to have_content('Hello, Rails!,These for all users')
  end
end
