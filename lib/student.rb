require 'pry'
class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.new_from_db(row)
    new_student = self.new  # self.new is the same as running Song.new
    new_student.id = row[0]
    new_student.name =  row[1]
    new_student.grade = row[2]
    new_student  # return the newly created instance
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
      LIMIT 1
    SQL
 
    DB[:conn].execute(sql, name).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.all_students_in_grade_9
    sql = <<-SQL
      SELECT *
      FROM students WHERE grade = "9"
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT *
      FROM students WHERE grade != "12"
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.all
    sql = <<-SQL
      SELECT *
      FROM students
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.first_X_students_in_grade_10(x)
    sql = <<-SQL
      SELECT *
      FROM students WHERE grade = "10" LIMIT #{x}
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

  def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT *
      FROM students WHERE grade = "10" LIMIT 1
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end.first
  end

  def self.all_students_in_grade_X(x)
    sql = <<-SQL
      SELECT *
      FROM students WHERE grade = #{x}
    SQL
 
    DB[:conn].execute(sql).map do |row|
      self.new_from_db(row)
    end
  end

end

# .new_from_db
# creates an instance with corresponding attribute values (FAILED - 1)
# retrieving data from the db
# .find_by_name
#   returns an instance of student that matches the name from the DB (FAILED - 2)
# .all_students_in_grade_9
#   returns an array of all students in grades 9 (FAILED - 3)
# .students_below_12th_grade
#   returns an array of all students in grades 11 or below (FAILED - 4)
# .all
#   returns all student instances from the db (FAILED - 5)
# .first_X_students_in_grade_10
#   returns an array of the first X students in grade 10 (FAILED - 6)
# .first_student_in_grade_10
#   returns the first student in grade 10 (FAILED - 7)
# .all_students_in_grade_X
#   returns an array of all students in a given grade X (FAILED - 8)