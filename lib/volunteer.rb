class Volunteer
  attr_accessor(:id, :name, :project_id)

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
      id = volunteer.fetch("id").to_i()
      project_id = volunteer.fetch("project_id").to_i()
      volunteers.push(Volunteer.new({:id => id, :name => name, :project_id => project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.find(id)
  found_volunteer = nil
  Volunteer.all().each() do |volunteer|
    if volunteer.id() == id.to_i()
      found_volunteer = volunteer
    end
  end
  found_volunteer
end

  def ==(other_volunteer)
    self.name().==(other_volunteer.name()).&(self.project_id().==(other_volunteer.project_id()))
  end

  define_method(:update) do |attributes|
   @name = attributes.fetch(:name)
   @id = self.id().to_i()

   DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

  define_method(:delete) do



   DB.exec("DELETE FROM volunteers WHERE id = #{self.id()};")
  end
end
