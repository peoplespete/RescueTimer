class Vice < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  validates :url, presence: true, uniqueness: true
  validates :category, presence: true


end
