# == Schema Information
#
# Table name: words
#
#  id          :integer          not null, primary key
#  translation :string
#  kana        :string
#  romaji      :string
#  kanji       :string
#  created_at  :datetime
#  updated_at  :datetime
#

class Word < ActiveRecord::Base
  has_many :course_items
  has_many :learned_words

  def to_label
    "#{translation} (#{romaji})"
  end

  def progress_for(user)
    learned_word = learned_words.where(user: user).first
    times_repeated = learned_word.times_repeated
    (times_repeated.to_f / 10.0) * 100
  end
end
