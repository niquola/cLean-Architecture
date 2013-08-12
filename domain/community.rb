require 'active_model'
class Community
  include ActiveModel::Model
  attr_accessor :id
  attr_accessor :title
  attr_accessor :location
  attr_accessor :technologies

  validates_presence_of :title
end
