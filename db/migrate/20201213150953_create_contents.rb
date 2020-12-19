class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.text :content
      t.integer :userid, null: false
      t.string :username, null: false
      t.references :article, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
