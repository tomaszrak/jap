class CreateProgress < ActiveRecord::Migration
  def change
    create_table :learned_words do |t|
      t.integer :times_repeated, default: 0
      t.boolean :completed, default: false
      t.datetime :last_learned
      t.references :word, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
