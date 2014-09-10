class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :hangmen
  has_many :challenged_games, class_name: "Hangman", foreign_key: "challenged_id"

  def all_games
    self.hangmen | self.challenged_games
  end

end
