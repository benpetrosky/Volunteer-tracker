require("rspec")
require("pg")
require("project")
require("volunteer")

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
      expect(project).to(eq(project2))
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
      test_volunteer = Volunteer.new({:id =>nil, :name => "Billy Jean", :project_id => test_project.id()})
      test_volunteer.save()
      test_volunteer2 = Volunteer.new({:id => nil, :name => "Michael Jackson", :project_id => test_project.id()})
      test_volunteer2.save()
      expect(test_project.volunteers()).to(eq([test_volunteer, test_volunteer2]))
    end
  end
  describe("#update") do
    it("lets you update projects in the database") do
      project = Project.new({:project_name => "Selflessly being selfless", :id => nil})
      project.save()
      project.update({:project_name => "Greedy people always lose"})
      expect(project.project_name()).to(eq("Greedy people always lose"))
    end
  end
  describe("#delete") do
    it("lets you delete a project from the database") do
      project = Project.new({:project_name => "Charity Drive", :id => nil})
      project.save()
      project2 = Project.new({:project_name => "Save the Rainforest", :id => nil})
      project2.save()
      project.delete()
      expect(Project.all()).to(eq([project2]))
    end
    it("deletes a project's volunteers from the database") do
     project = Project.new({:project_name => "Epicodus stuff", :id => nil})
     project.save()
     volunteer = Volunteer.new({:id => nil, :name => "James Dean", :project_id => project.id()})
     volunteer.save()
     volunteer2 = Volunteer.new({:id => nil, :name => "Jimmy Hendricks", :project_id => project.id()})
     volunteer2.save()
     project.delete()
     expect(Volunteer.all()).to(eq([]))
   end
  end
end
