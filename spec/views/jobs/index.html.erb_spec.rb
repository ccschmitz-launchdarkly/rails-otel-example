require 'rails_helper'

RSpec.describe "jobs/index", type: :view do
  before(:each) do
    assign(:jobs, [
      Job.create!(
        title: "Title",
        company: "Company",
        description: "MyText",
        salary: "9.99",
        location: "Location",
        status: "Status"
      ),
      Job.create!(
        title: "Title",
        company: "Company",
        description: "MyText",
        salary: "9.99",
        location: "Location",
        status: "Status"
      )
    ])
  end

  it "renders a list of jobs" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "Company".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "Location".to_s, count: 2
    assert_select "tr>td", text: "Status".to_s, count: 2
  end
end
