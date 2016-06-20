class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  

  attr_accessor :grade
  attr_reader :name, :id


  def self.db
  	DB[:conn]
  end

  def self.drop_table
  		sql = <<-SQL
      DROP TABLE students;
    SQL

    db.execute(sql)
  end

 	def self.create_table
 		sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade INTEGER
      )
    SQL

    db.execute(sql)

 	end

  def initialize(name, grade)
  	@name = name
  	@grade = grade
  end

  def save
    sql = <<-SQL    
    INSERT INTO students (name, grade) VALUES
    (?, ?);
    SQL

    self.class.db.execute(sql, self.name, self.grade)
    @id = self.class.db.last_insert_row_id
  end

  def self.create(attributes = {})
  	name = attributes[:name]
  	grade = attributes[:grade]
  	student = Student.new(name, grade)
  	student.save
  	student

  end
  
end












