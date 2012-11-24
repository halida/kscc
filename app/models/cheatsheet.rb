class Cheatsheet < ActiveRecord::Base
  attr_accessible :desc, :layout, :title

  has_many :groups
  has_many :shortcuts
end
