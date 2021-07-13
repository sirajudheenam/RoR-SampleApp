require 'rails_helper'

RSpec.describe "instruments/index", type: :view do
  before(:each) do
    assign(:instruments, [
      Instrument.create!(
        title: "Title",
        token: "Token",
        count: ""
      ),
      Instrument.create!(
        title: "Title",
        token: "Token",
        count: ""
      )
    ])
  end

  it "renders a list of instruments" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Token".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end
