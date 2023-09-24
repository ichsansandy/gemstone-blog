require 'rails_helper'

RSpec.describe 'posts/show.html.erb', type: :view do
  it "displays the expected content" do
    render
    expect(rendered).to have_content('this is for showing 1 post id')
  end
end
