require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/volunteer")
require("./lib/project")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get("/") do
  erb(:index)
end

get('/projects') do
  @projects = Project.all()
  erb(:projects)
end

get("/projects/new") do
  erb(:project_form)
end

post("/projects") do
  project_name = params.fetch("project_name")
  project = Project.new({:project_name => project_name, :id => nil})
  project.save()
  erb(:project_success)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  erb(:project)
end

delete("/project_delete/:id") do
  id = params.fetch("id").to_i
  project = Project.find(id)
  project.delete()
  @projects = Project.all()
  erb(:projects)
end


get("/volunteers") do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

post("/volunteers") do
  name = params.fetch("name")
  project_id = params.fetch("project_id")
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:id => nil, :name => name, :project_id => project_id})
  @volunteer.save()
  erb(:volunteer_success)
end

patch("/update_project/:id") do
  id = params.fetch("id").to_i
  name = params.fetch("name")
  @project = Project.find(id)
  @project.update(:project_name => name)
  erb(:project)
end
# here

get("/volunteer/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  erb(:volunteer)
end

get("/volunteer_delete/volunteer/:id") do
  @volunteer = Volunteer.find(params.fetch("id").to_i())
  erb(:volunteer)
end

delete("/volunteer_delete/:id") do
  id = params.fetch("id").to_i
  volunteer = Volunteer.find(id)
  volunteer.delete()
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

patch('/update_volunteer/:id') do
  id = params.fetch("id").to_i
  name = params.fetch("name")
  @volunteer = Volunteer.find(id)
  @volunteer.update(:name => name)
  erb(:volunteer)
end
