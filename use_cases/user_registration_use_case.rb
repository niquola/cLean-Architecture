require 'ostruct'

class UserRegistrationUseCase
  extend UseCase

  def initialize(*context)
  end

  command :register

  command :confirm do |attrs|
    OpenStruct.new(:ok? => true, message: 'Confirmation was sent to')
  end

  query :confirmaton_for do |login|
    OpenStruct.new(key: 'agasdfd asfsad')
  end
end

