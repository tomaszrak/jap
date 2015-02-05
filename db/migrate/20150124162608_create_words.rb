class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :translation
      t.string :kana
      t.string :romaji
      t.string :kanji

      t.timestamps
    end
  end
end
