# == Schema Information
#
# Table name: learned_words
#
#  id             :integer          not null, primary key
#  times_repeated :integer          default("0")
#  completed      :boolean          default("false")
#  last_learned   :datetime
#  word_id        :integer
#  user_id        :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class LearnedWord < ActiveRecord::Base
  belongs_to :word
  belongs_to :user

  delegate :translation, :romaji, :kana, :kanji, to: :word

  def self.items_for(course_id)
    joins(word: :course_items).where(course_items: { course_id: course_id }).order('last_learned asc').limit 10
  end
end
