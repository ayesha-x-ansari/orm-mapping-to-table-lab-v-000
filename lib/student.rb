class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade, id = nil)
    @name  = name
    @grade  = grade
    @id =  id
  end

  def self.create_table
    sql = <<-SQL
            CREATE TABLE IF NOT EXISTS students (
                                        id INTEGER PRIMARY KEY,
                                        name TEXT,
                                        grade INTEGER)
              SQL
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-SQL
            DROP TABLE IF EXISTS students
              SQL
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL
    self.name = "Josh"
    self.grade = "9th"
    puts sql
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end
  This is a class method that uses keyword arguments. The keyword arguments are name: and grade:.
  Use the values of these keyword arguments to: 1) instantiate a new Student object with
  Student.new(name, grade) and 2) save that new student object via student.save. The
  #create method should return the student object that it creates.

 def self.create(name:, grade:)
   student = self.new(name, grade)
   student.save
   student

 end
end
