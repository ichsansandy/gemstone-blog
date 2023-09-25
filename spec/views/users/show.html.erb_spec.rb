require 'rails_helper'

RSpec.describe 'users/show.html.erb', type: :view do
  it 'displays the expected content' do
    render
    expect(rendered).to have_content('This is user per id')
  end
end