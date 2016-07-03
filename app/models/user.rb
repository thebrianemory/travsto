class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :email, :username, :password, :password_confirmation
  validates_uniqueness_of :username, :email
  validates :username, format: { with: /\A[a-z0-9]{6,15}\z/i }
  has_many :trips, dependent: :destroy
  has_many :comments
  enum role: [:user, :admin]

  extend FriendlyId
  friendly_id :username, use: :slugged

  def name
    [first_name, last_name]. join(' ')
  end
end
