class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :email, :username
  validates_uniqueness_of :username, :email
  validates :username, length: 6..15
  has_many :trips, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def name
    [first_name, last_name]. join(' ')
  end
end
