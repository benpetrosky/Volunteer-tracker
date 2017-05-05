class Volunteer
  attr_accessor(:id, :name)

  def initialize(attributes)
    @id = attributes.fetch(:id)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteers.fetch("project_id").to_i()
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id}))
    end
    volunteers
  end

  def save
    DB.exec("INSERT INTO (name, project_id) VALUES (#{@name}, #{@project_id});")
  end

  def ==(other_volunteer)
    self.name().==(other_volunteer.name()).&(self.project_id().==(other_volunteer.project_id()))
  end
end
