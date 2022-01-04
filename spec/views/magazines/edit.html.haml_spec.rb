require 'rails_helper'

RSpec.describe "magazines/edit", type: :view do
  before(:each) do
    @magazine = assign(:magazine, Magazine.create!(
      name: "MyString",
      publisher_id: "MyString"
    ))
  end

  it "renders the edit magazine form" do
    render

    assert_select "form[action=?][method=?]", magazine_path(@magazine), "post" do

      assert_select "input[name=?]", "magazine[name]"

      assert_select "input[name=?]", "magazine[publisher_id]"
    end
  end
end
