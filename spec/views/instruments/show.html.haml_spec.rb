require 'rails_helper'

RSpec.describe "instruments/show", type: :view do
  before(:each) do
    @instrument = assign(:instrument, Instrument.create!(
      title: "Title",
      token: "Token",
      count: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Token/)
    expect(rendered).to match(//)
  end
end
