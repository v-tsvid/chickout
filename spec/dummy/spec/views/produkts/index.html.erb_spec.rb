require 'rails_helper'

RSpec.describe "produkts/index", type: :view do
  before(:each) do
    assign(:produkts, [
      Produkt.create!(
        :title => "Title",
        :price => "9.99"
      ),
      Produkt.create!(
        :title => "Title",
        :price => "9.99"
      )
    ])
  end

  it "renders a list of produkts" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
