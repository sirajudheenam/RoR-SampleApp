require 'rails_helper'

RSpec.describe "magazines/show", type: :view do
  before(:each) do
    @magazine = assign(:magazine, Magazine.create!(
      name: "Name",
      publisher_id: "Publisher"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Publisher/)
  end
end
