require 'rails_helper'

RSpec.describe "produkts/show", type: :view do
  before(:each) do
    @produkt = assign(:produkt, Produkt.create!(
      :title => "Title",
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/9.99/)
  end
end
