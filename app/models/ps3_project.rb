class Ps3Project < ApplicationRecord
  has_many :ps3_project_students
  has_many :ps3_students, through: :ps3_project_students

  validates_presence_of :name
  validates_uniqueness_of :name
end