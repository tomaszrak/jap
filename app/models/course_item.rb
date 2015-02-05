# == Schema Information
#
# Table name: course_items
#
#  id         :integer          not null, primary key
#  word_id    :integer
#  course_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class CourseItem < ActiveRecord::Base
  belongs_to :word
  belongs_to :course

  delegate :translation, :romaji, :kana, :kanji, to: :word
end
