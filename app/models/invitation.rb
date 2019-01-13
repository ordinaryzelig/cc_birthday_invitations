class Invitation < ApplicationRecord

  has_many :song_requests

  enum :status => {
    :going     => 1,
    :not_going => 2,
    :undecided => 0,
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

  def name
    [
      first_name,
      last_name,
    ].join(' ')
  end

private

  def generate_code
    self.code = SecureRandom.hex(3)
  end

  def generate_dj_name
    self.dj_name = DJName.rand
  end

end
