class SongRequest < ApplicationRecord

  belongs_to :invitation

  validates :title, :presence => true
  validates :artist, :presence => true

end
