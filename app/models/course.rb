class Course < ActiveRecord::Base
  belongs_to :course_type
  has_many :subjects
end
