class Message < ActiveRecord::Base
  belongs_to :conversation
  attr_accessible :content, :email, :phone, :incoming
end
