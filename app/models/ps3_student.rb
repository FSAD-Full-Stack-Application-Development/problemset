class Ps3Student < ApplicationRecord
  has_many :ps3_project_students
  has_many :ps3_projects, through: :ps3_project_students

  validates_presence_of :name
  validates_presence_of :studentid
  validates_uniqueness_of :name
end