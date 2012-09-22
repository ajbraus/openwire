class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :conversations
      t.string 		 :phone
      t.string		 :email
      t.string 		 :content
      
      t.timestamps
    end
    add_index :messages, :conversations_id
  end
end
