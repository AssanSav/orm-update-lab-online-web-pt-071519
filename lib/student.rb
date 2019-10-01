require_relative "../config/environment.rb"

class Student
  attr_accessor :name, :grade 
  attr_reader :id 
  
  def initialize(id=nil, name, grade)
    @id = id 
    @name = name
    @grade = grade 
  end
  
  def self.create_table 
    sql = "CREATE TABLE IF NOT EXISTS students (id INTEGER PRIMARY KEY, name TEXT, grade TEXT)"
    DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE students"
    DB[:conn].execute(sql)
  end
  
  def save 
    if self.id
      self.update
    else 
    sql = "INSERT INTO students (name, grade) VALUES (?, ?)"
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowId() FROM students")[0][0]
     end
  end
  
  def self.new_from_db(row)
    student = Student.new 
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end
  
  def self.find_by_name(name) 
    sql = "SELECT * FROM students WHERE name = ? LIMIT 1"
    DB[:conn].execute(sql, name).map do |row|
      binding.pry
      Student.new_from_db(row)
      
    end
  end
  
  def update 
    sql = "UPDATE students SET name = ?, grade = ? 
    WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.grade, self.id)
  end
end
