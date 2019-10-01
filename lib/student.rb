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
    sql = "DROP TABLE self"
    DB[:conn].execute(sql)
  end
  
  def save 
    sql = "INSERT INTO students "
  end
end
