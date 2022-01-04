require 'rails_helper'

RSpec.describe "magazines/new", type: :view do
  before(:each) do
    assign(:magazine, Magazine.new(
      name: "MyString",
      publisher_id: "MyString"
    ))
  end

  it "renders new magazine form" do
    render

    assert_select "form[action=?][method=?]", magazines_path, "post" do

      assert_select "input[name=?]", "magazine[name]"

      assert_select "input[name=?]", "magazine[publisher_id]"
    end
  end
end
