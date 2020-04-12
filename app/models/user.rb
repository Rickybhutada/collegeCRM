class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  serialize :course,  JSON
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_one :user_role, dependent: :destroy
  scope :get_student, -> {joins(:user_role).where(:user_roles=>{:role_id=>STUDENT})}
  scope :get_teacher, -> {joins(:user_role).where(:user_roles=>{:role_id=>TEACHER})}

end
