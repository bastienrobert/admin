require 'rails_helper'

RSpec.describe "periods/show", type: :view do
  before(:each) do
    @period = assign(:period, Period.create!(
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
