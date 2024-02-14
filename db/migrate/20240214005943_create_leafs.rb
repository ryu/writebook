class CreateLeafs < ActiveRecord::Migration[7.2]
  def change
    create_table :leafs do |t|
      t.references :book, null: false, foreign_key: true
      t.references :leafable, polymorphic: true, null: false
      t.references :parent, foreign_key: true
      t.integer :position
      t.string :status

      t.timestamps
    end
  end
end
