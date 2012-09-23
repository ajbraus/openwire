class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversation
      t.string 		 :phone
      t.string		 :email
      t.string 		 :content
      t.boolean :incoming

      t.timestamps
    end
    add_index :messages, :conversation_id
  end
end
