class CreateFilms < ActiveRecord::Migration[7.1]
  def change
    create_table :films do |t|
      t.string :title
      t.integer :year
      t.string :category
      t.integer :score
      t.string :status
      t.string :trailer
      t.text :description
      t.text :actors
      t.string :director

      t.timestamps
    end
  end
end
