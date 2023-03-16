class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :descrip
      t.string :status, default: "pending"
      t.date :deadline
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
