require_relative '../config'
#THIS MIGRATION MUST BE RUN AFTER THE TABLE IS SEEDED

# this is where you should use an ActiveRecord migration to 

class ChangeStudents < ActiveRecord::Migration
  def up
    add_column :students, :name, :string
    Student.all.each do  |student| 
      student.name = "#{student.first_name} #{student.last_name}"
      student.save!
    end
    remove_column :students, :first_name, :string
    remove_column :students, :last_name, :string
  end

  def down
    add_column :students, :first_name, :string
    add_column :students, :last_name, :string
    Student.all.each do  |student| 
      split_name = student.name.split
      student.first_name = split_name[0]
      student.last_name = split_name[1]
      student.save!
    end
    remove_column :students, :name, :string
  end
end