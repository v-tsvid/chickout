require 'rails_helper'

RSpec.describe "produkts/edit", type: :view do
  before(:each) do
    @produkt = assign(:produkt, Produkt.create!(
      :title => "MyString",
      :price => "9.99"
    ))
  end

  it "renders the edit produkt form" do
    render

    assert_select "form[action=?][method=?]", produkt_path(@produkt), "post" do

      assert_select "input#produkt_title[name=?]", "produkt[title]"

      assert_select "input#produkt_price[name=?]", "produkt[price]"
    end
  end
end
