

class Project
  attr_accessor(:id, :project_name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @project_name = attributes.fetch(:project_name)
  end

  define_singleton_method(:all) do
      returned_projects = DB.exec("SELECT * FROM projects;")
      projects = []
      returned_projects.each() do |project|
        project_name = project.fetch("project_name")
        id = project.fetch("id").to_i()
        projects.push(Project.new({:project_name => project_name, :id => id}))
      end
      projects
    end

    define_method(:save) do
      result = DB.exec("INSERT INTO projects (project_name) VALUES ('#{@project_name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_project|
      self.project_name().==(another_project.project_name()).&(self.id().==(another_project.id()))
    end

    define_singleton_method(:find) do |id|
      found_project = nil
      Project.all().each() do |project|
        if project.id().==(id)
          found_project = project
        end
      end
      found_project
    end

    define_method(:volunteers) do
      project_volunteers = []
      volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id()};")
      volunteers.each() do |volunteer|
        name = volunteer.fetch("name")
        project_id = volunteer.fetch("project_id").to_i()
        project_volunteers.push(Volunteer.new({:name => name, :project_id => project_id}))
      end
      project_volunteers
    end

  define_method(:update) do |attributes|
    @project_name = attributes.fetch(:project_name)
    @id = self.id()
    DB.exec("UPDATE projects SET project_name = '#{@project_name}' WHERE id = #{@id};")
  end
  define_method(:delete) do
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
    DB.exec("DELETE FROM volunteers WHERE project_id = #{self.id()};")
  end

end
