class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.string :term
      t.string :code
      t.string :subjects

      t.timestamps
    end
  end
end
