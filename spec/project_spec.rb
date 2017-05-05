require("rspec")
require("pg")
require("project")

DB = PG.connect({:dbname => 'volunteer_tracker_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM projects *;")
  end
end
describe(Project) do

  describe(".all") do
    it("starts off with no projects") do
      expect(Project.all()).to(eq([]))
    end
  end

  describe("#project_name") do
    it("tells you its name of the project") do
      project = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      expect(project.project_name()).to(eq("Feed the animals drive"))
    end
  end

  describe("#id") do
    it("sets its ID when you save it") do
      project = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      project.save()
      expect(project.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe("#save") do
    it("lets you save projects to the database") do
      project = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      project.save()
      expect(Project.all()).to(eq([project]))
    end
  end

  describe("#==") do
    it("is the same prect if it has the same name") do
      project = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      project2 = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      expect(project1).to(eq(project2))
    end
  end

  describe(".find") do
    it("returns a project by its ID") do
      test_project = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      test_project.save()
      test_project2 = Project.new({:id => nil, :project_name => "Adoption Fall Fundraiser"})
      test_project2.save()
      expect(Project.find(test_project2.id())).to(eq(test_project2))
    end
  end

  describe("#volunteers") do
    it("returns an array of volunteers working on that project") do
      test_project = Project.new({:id => nil, :project_name => "Feed the animals drive"})
      test_project.save()
      test_volunteer = Volunteer.new({:id => nil, :name => "Billy Jean", :project_id => test_project.id()})
      test_volunteer.save()
      test_volunteer2 = Volunteer.new({:id => nil, :name => "Michael Jackson", :project_id => test_project.id()})
      test_volunteer2.save()
      expect(test_project.volunteers()).to(eq([test_volunteer, test_volunteer2]))
    end
  end
end
