class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { inspector: 0, super: 100 }

  has_many :reports, inverse_of: :admin

  def name
  	self.first_name + " " + self.last_name
  end
end
