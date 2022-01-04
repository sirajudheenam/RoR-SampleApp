require 'rails_helper'

RSpec.describe "publishers/edit", type: :view do
  before(:each) do
    @publisher = assign(:publisher, Publisher.create!(
      name: "MyString",
      owner: "MyString"
    ))
  end

  it "renders the edit publisher form" do
    render

    assert_select "form[action=?][method=?]", publisher_path(@publisher), "post" do

      assert_select "input[name=?]", "publisher[name]"

      assert_select "input[name=?]", "publisher[owner]"
    end
  end
end
