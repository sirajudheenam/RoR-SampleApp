require 'rails_helper'

RSpec.describe "publishers/index", type: :view do
  before(:each) do
    assign(:publishers, [
      Publisher.create!(
        name: "Name",
        owner: "Owner"
      ),
      Publisher.create!(
        name: "Name",
        owner: "Owner"
      )
    ])
  end

  it "renders a list of publishers" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Owner".to_s, count: 2
  end
end
