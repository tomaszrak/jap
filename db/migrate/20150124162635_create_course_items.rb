class CreateCourseItems < ActiveRecord::Migration
  def change
    create_table :course_items do |t|
      t.references :word, index: true
      t.references :course, index: true

      t.timestamps
    end
  end
end
