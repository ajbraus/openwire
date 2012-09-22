class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :messages
      t.integer :from_phone
      t.string :from_email

      t.timestamps
    end
    add_index :conversations, :messages_id
    add_index :conversations, :from_phone
    add_index :conversations, :from_email
  end
end
