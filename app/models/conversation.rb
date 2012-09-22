class Conversation < ActiveRecord::Base
  has_many :incoming_messages, class_name: :messages
  has_many :outgoing_messages, class_name: :messages
  has_many :messages
  belongs_to :user

  def elapsed_time
  	(Time.now - self.message.last.created_at).strftime("%l") + ":" + (Time.now - self.message.last.created_at).strftime("%M")
  end

  def from
  	if self.phone && !self.email 
  		self.phone
  	elsif self.email && !self.phone
  		self.email
  	elsif self.phone && self.email
  		self.phone + self.email
  	end
  end
end