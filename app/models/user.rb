class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :phone, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_many :conversations, :dependent => :destroy

  validate :phone, prensence: true, unique: true
  validates_format_of :phone, :with => /\A[0-9]{10}\Z/
end