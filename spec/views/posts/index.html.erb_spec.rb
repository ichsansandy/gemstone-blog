require 'rails_helper'

RSpec.describe 'posts/index.html.erb', type: :view do
  it "displays the expected content" do
    render
    expect(rendered).to have_content('this is for all posts in 1 user')
  end
end
