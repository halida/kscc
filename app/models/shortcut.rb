class Shortcut < ActiveRecord::Base
  attr_accessible :desc, :key

  belongs_to :cheatsheet
  belongs_to :group
end
