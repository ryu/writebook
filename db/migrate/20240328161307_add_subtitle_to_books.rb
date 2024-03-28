class AddSubtitleToBooks < ActiveRecord::Migration[7.2]
  def change
    change_table :books do |t|
      t.string :subtitle
    end
  end
end
