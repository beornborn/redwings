require 'rails_helper'

RSpec.describe Project, type: :model do
  #pending "add some examples to (or delete) #{__FILE__}"
  before(:each) do
    @attr = { :name => "Example Project"}
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@attr)
  end

  it "should require a name" do
    no_name_project = Project.new(@attr.merge(:name => ""))
    expect(no_name_project).not_to be_valid
  end
end
