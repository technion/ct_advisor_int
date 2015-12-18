class Registration < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save { self.domain = domain.downcase }
  validates :domain, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true
  validates :active, presence: true, format: { with: /\A[01]\z/ }

  def set_nonce
    self.nonce = SecureRandom.urlsafe_base64
  end
end
