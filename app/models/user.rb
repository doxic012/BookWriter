class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  # :recoverable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
  attr_accessible :login
  attr_accessor :login

  has_and_belongs_to_many :books
  has_many :chunks

  validates_presence_of :first_name, :last_name
  validates :username, :uniqueness => {:case_sensitive => false}

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", {:value => login.downcase}]).first
    else
      where(conditions).first
    end
  end

end
