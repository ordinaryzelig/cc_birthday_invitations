class Invitation < ApplicationRecord

  enum :status => {
    :has_not_responded => 0,
    :accepted          => 1,
    :declined          => 2,
  }

  before_validation :generate_code, :unless => :code?

  validates :first_name, :presence => true, :unless => :has_not_responded?
  validates :last_name, :presence => true, :unless => :has_not_responded?
  validates :email, :presence => true, :unless => :has_not_responded?
  validates :status, :presence => true
  validates :code, :presence => true

  def to_param
    code
  end

private

  def generate_code
    self.code = SecureRandom.hex(3)
  end

end
