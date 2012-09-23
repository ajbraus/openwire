class Conversation < ActiveRecord::Base
  has_many :messages
  belongs_to :user

  attr_accessible :from_phone, :from_email

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