

class Project
  attr_accessor(:id, :project_name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @project_name = attributes.fetch(:project_name)
  end
end
