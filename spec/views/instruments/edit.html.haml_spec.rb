require 'rails_helper'

RSpec.describe "instruments/edit", type: :view do
  before(:each) do
    @instrument = assign(:instrument, Instrument.create!(
      title: "MyString",
      token: "MyString",
      count: ""
    ))
  end

  it "renders the edit instrument form" do
    render

    assert_select "form[action=?][method=?]", instrument_path(@instrument), "post" do

      assert_select "input[name=?]", "instrument[title]"

      assert_select "input[name=?]", "instrument[token]"

      assert_select "input[name=?]", "instrument[count]"
    end
  end
end
