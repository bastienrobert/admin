require 'rails_helper'

RSpec.describe "periods/edit", type: :view do
  before(:each) do
    @period = assign(:period, Period.create!(
      :user => nil
    ))
  end

  it "renders the edit period form" do
    render

    assert_select "form[action=?][method=?]", period_path(@period), "post" do

      assert_select "input[name=?]", "period[user_id]"
    end
  end
end
