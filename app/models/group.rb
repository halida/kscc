class Group < ActiveRecord::Base
  attr_accessible :desc, :name, :color

  belongs_to :cheatsheet
  has_many :shortcuts

  def color
    self[:color] || '#fff'
  end

end
