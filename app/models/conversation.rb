class Conversation < ActiveRecord::Base
  has_many :messages, :dependent => :destroy
  belongs_to :user

  attr_accessible :from_phone, :from_email


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