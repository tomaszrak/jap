# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#

class Course < ActiveRecord::Base
  has_many :course_items
  has_many :words, through: :course_items
  has_many :learnings

  def learned_by?(user)
    learnings.where(user: user).present?
  end
end
