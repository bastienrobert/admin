require 'rails_helper'

RSpec.describe "periods/index", type: :view do
  before(:each) do
    assign(:periods, [
      Period.create!(
        :user => nil
      ),
      Period.create!(
        :user => nil
      )
    ])
  end

  it "renders a list of periods" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
