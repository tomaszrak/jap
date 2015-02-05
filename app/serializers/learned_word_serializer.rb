class LearnedWordSerializer < ActiveModel::Serializer
  attributes :id, :times_repeated, :last_learned, :translation, 
             :romaji, :kana, :kanji, :is_new, :completed,
             :show_romaji, :show_kana, :show_kanji, :show_only_romaji

  private

  def is_new
    object.times_repeated == 0
    true
  end

  def show_romaji
    return false if show_only_romaji
    true
  end

  def show_kana
    return false if show_only_romaji
    return true if show_kanji && object.kanji.nil?
    true
  end

  def show_kanji
    return false if show_only_romaji
    true
  end

  def show_only_romaji
    false
  end

  def times_repeated
    object.times_repeated || 0
  end
end
