require 'rails_helper'

RSpec.describe "produkts/new", type: :view do
  before(:each) do
    assign(:produkt, Produkt.new(
      :title => "MyString",
      :price => "9.99"
    ))
  end

  it "renders new produkt form" do
    render

    assert_select "form[action=?][method=?]", produkts_path, "post" do

      assert_select "input#produkt_title[name=?]", "produkt[title]"

      assert_select "input#produkt_price[name=?]", "produkt[price]"
    end
  end
end
