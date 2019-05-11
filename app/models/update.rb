class Update < ApplicationRecord
  belongs_to :user
  belongs_to :podcast, optional: true
  has_many :likes

  def email
    self.user.email
  end
end
