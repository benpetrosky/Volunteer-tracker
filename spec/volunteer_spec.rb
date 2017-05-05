require("rspec")
require("pg")
require("volunteer")

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM volunteers *;")
  end
end
describe(Volunteer) do

  describe(".all") do
  it("is empty at first") do
    expect(Volunteer.all()).to(eq([]))
  end
end

describe("#save") do
  it("adds a task to the array of saved tasks") do
    test_volunteer = Volunteer.new({:id => nil, :name => "Lara Croft", :project_id => 1})
    test_volunteer.save()
    expect(Volunteer.all()).to(eq([test_volunteer]))
  end
end

describe("#name") do
  it("lets you read the name of a volunteer") do
    test_volunteer = Volunteer.new({:id => nil, :name => "Clint Dempsey", :project_id => 1})
    expect(test_volunteer.name()).to(eq("Clint Dempsey"))
  end
end

# here
  describe("#==") do
   it("is the same volunteer if it has the same name") do
     volunteer1 = Volunteer.new({:id => nil, :name => "James Dean", :project_id => 1})
     volunteer2 = Volunteer.new({:id => nil, :name => "James Dean", :project_id => 1})
     expect(volunteer1).to(eq(volunteer2))
   end
 end

end
