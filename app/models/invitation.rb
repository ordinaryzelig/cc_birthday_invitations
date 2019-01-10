class Invitation < ApplicationRecord

  has_many :song_requests

  enum :status => {
    :undecided => 0,
    :going     => 1,
    :declined  => 2,
  }

  before_validation :generate_code, :unless => :code?
  before_validation :generate_dj_name, :if => -> { dj_name.blank? && going? }

  validates :first_name, :presence => true, :unless => :undecided?
  validates :last_name, :presence => true, :unless => :undecided?
  validates :email, :presence => true, :unless => :undecided?
  validates :status, :presence => true
  validates :code, :presence => true

  def to_param
    code
  end

private

  def generate_code
    self.code = SecureRandom.hex(3)
  end

  def generate_dj_name
    self.dj_name = DJName.rand
  end

end
