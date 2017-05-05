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

get("/volunteers") do
  @volunteers = Volunteer.all()
  erb(:volunteers)
end

post("/volunteers") do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i()
  @project = Project.find(project_id)
  @volunteer = Volunteer.new({:name => name, :project_id => project_id})
  @volunteer.save()
  erb(:volunteer_success)
end
