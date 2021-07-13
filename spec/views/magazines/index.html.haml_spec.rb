require 'rails_helper'

RSpec.describe "magazines/index", type: :view do
  before(:each) do
    assign(:magazines, [
      Magazine.create!(
        name: "Name",
        publisher_id: "Publisher"
      ),
      Magazine.create!(
        name: "Name",
        publisher_id: "Publisher"
      )
    ])
  end

  it "renders a list of magazines" do
    render
    assert_select "tr>td", text: "Name".to_s, count: 2
    assert_select "tr>td", text: "Publisher".to_s, count: 2
  end
end
