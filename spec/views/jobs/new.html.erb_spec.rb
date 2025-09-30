require 'rails_helper'

RSpec.describe "jobs/new", type: :view do
  before(:each) do
    assign(:job, Job.new(
      title: "MyString",
      company: "MyString",
      description: "MyText",
      salary: "9.99",
      location: "MyString",
      status: "MyString"
    ))
  end

  it "renders new job form" do
    render

    assert_select "form[action=?][method=?]", jobs_path, "post" do

      assert_select "input[name=?]", "job[title]"

      assert_select "input[name=?]", "job[company]"

      assert_select "textarea[name=?]", "job[description]"

      assert_select "input[name=?]", "job[salary]"

      assert_select "input[name=?]", "job[location]"

      assert_select "input[name=?]", "job[status]"
    end
  end
end
