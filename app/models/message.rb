class Message < ActiveRecord::Base
  belongs_to :conversation
  attr_accessible :content, :email, :phone, :incoming

  def elapsed_time
  	Time.diff(Time.now, self.created_at, '%N')[:diff]
  end
end
