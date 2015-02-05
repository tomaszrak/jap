class CreateLearning < ActiveRecord::Migration
  def change
    create_table :learnings do |t|
      t.datetime :started_at
      t.datetime :finished_at
      t.references :user, index: true
      t.references :course, index: true

      t.timestamps
    end
  end
end
